const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const source = fs.readFileSync('assets/js/research.js', 'utf8');

function harness({ready = true, clipboardFails = false} = {}) {
  const events = [], handlers = {}, status = {textContent: ''};
  const button = {dataset: {copyCitation: 'citation', publicationKey: 'paper-key'}, hidden: true,
    closest: () => ({querySelector: () => status}), addEventListener: (_, fn) => {handlers.copy = fn;}};
  const controls = ['topic', 'tag', 'year'].map(type => ({id: `publication-${type}`, value: type === 'topic' ? 'integrity' : '',
    addEventListener: (_, fn) => {handlers[type] = fn;}}));
  const selectors = [];
  const document = {
    querySelectorAll(selector) {selectors.push(selector); return selector === '[data-copy-citation]' ? [button] : controls;},
    getElementById: () => ({textContent: ' Verified citation '}),
    addEventListener: (_, fn) => {handlers.click = fn;},
    createRange: () => ({selectNodeContents() {}})
  };
  vm.runInNewContext(source, {document, location: {pathname: '/publications/paper/', search: '?q=private-query'},
    navigator: {clipboard: {async writeText(value) {assert.equal(value, 'Verified citation'); if (clipboardFails) throw Error('denied');}}},
    window: {soscdAnalyticsReady: ready, gtag: (...args) => events.push(JSON.parse(JSON.stringify(args))),
      getSelection: () => ({removeAllRanges() {}, addRange() {}})}});
  return {events, handlers, status, button, selectors};
}

test('successful citation copy reports the paper ID only after copying', async () => {
  const h = harness();
  await h.handlers.copy();
  assert.equal(h.status.textContent, 'Citation copied.');
  assert.equal(h.button.disabled, false);
  assert.deepEqual(h.events, [['event', 'citation_copy', {publication_id: 'paper-key', page_path: '/publications/paper/'}]]);
});
test('failed clipboard copy offers manual copying without claiming an analytics success', async () => {
  const h = harness({clipboardFails: true}); await h.handlers.copy();
  assert.match(h.status.textContent, /Copy command/); assert.equal(h.events.length, 0); assert.equal(h.button.disabled, false);
});
test('local or inactive analytics never sends research events', async () => {
  const h = harness({ready: false}); await h.handlers.copy(); h.handlers.topic(); assert.equal(h.events.length, 0);
});
test('taxonomy filtering sends explicit selections and does not register free-text search', () => {
  const h = harness(); h.handlers.topic();
  assert.deepEqual(h.events, [['event', 'publication_filter', {filter_type: 'topic', filter_value: 'integrity'}]]);
  assert.equal(h.selectors.some(s => s.includes('publication-query')), false);
  assert.equal(JSON.stringify(h.events).includes('private-query'), false);
});
test('resource opens carry the resource and paper identifiers', () => {
  const h = harness();
  h.handlers.click({target: {closest: selector => selector === 'a[data-resource-type]' ? {dataset: {resourceType: 'code', publicationKey: 'paper-key'}} : null}});
  assert.deepEqual(h.events, [['event', 'research_resource_open', {resource_type: 'code', publication_id: 'paper-key', page_path: '/publications/paper/'}]]);
});
