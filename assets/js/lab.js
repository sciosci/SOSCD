(() => {
  'use strict';

  const menuButton = document.querySelector('.menu-toggle');
  const nav = document.querySelector('.primary-nav');
  if (menuButton && nav) {
    document.documentElement.classList.add('has-js');
    const closeMenu = () => {
      menuButton.setAttribute('aria-expanded', 'false');
      nav.classList.remove('is-open');
    };
    menuButton.addEventListener('click', () => {
      const open = menuButton.getAttribute('aria-expanded') !== 'true';
      menuButton.setAttribute('aria-expanded', String(open));
      nav.classList.toggle('is-open', open);
    });
    document.addEventListener('keydown', event => {
      if (event.key === 'Escape' && nav.classList.contains('is-open')) {
        closeMenu();
        menuButton.focus();
      }
    });
    document.addEventListener('click', event => {
      if (!event.target.closest('.site-header')) closeMenu();
    });
    nav.addEventListener('click', event => { if (event.target.closest('a')) closeMenu(); });
    matchMedia('(min-width: 961px)').addEventListener('change', event => { if (event.matches) closeMenu(); });
  }

  const lens = document.querySelector('[data-research-lens]');
  if (lens) {
    const controls = lens.querySelector('[data-lens-controls]');
    const papers = JSON.parse(document.querySelector('#lens-paper-data').textContent);
    const topics = JSON.parse(document.querySelector('#lens-topic-data').textContent);
    const nodes = [...lens.querySelectorAll('.research-node')];
    const copy = lens.querySelector('[data-lens-copy]');
    const link = lens.querySelector('[data-lens-link]');
    const allHref = link.getAttribute('href');
    const stage = lens.querySelector('.lens-stage');
    const preview = lens.querySelector('.paper-preview');
    let activeNode = null;
    let dismissedNode = null;
    let hideTimer;
    const hidePreview = () => {
      clearTimeout(hideTimer);
      activeNode?.removeAttribute('aria-describedby');
      activeNode?.classList.remove('is-previewing');
      activeNode = null;
      preview.hidden = true;
    };
    const positionPreview = () => {
      if (!activeNode) return;
      const frame = stage.getBoundingClientRect();
      const point = activeNode.getBoundingClientRect();
      const width = preview.offsetWidth;
      const height = preview.offsetHeight;
      const x = Math.max(8, Math.min(point.x - frame.x + point.width / 2 - width / 2, frame.width - width - 8));
      const below = point.bottom - frame.top + 10;
      const y = below + height <= frame.height - 8 ? below : Math.max(8, point.top - frame.top - height - 10);
      preview.style.left = `${x}px`;
      preview.style.top = `${y}px`;
    };
    const showPreview = node => {
      clearTimeout(hideTimer);
      if (dismissedNode === node || activeNode === node) return;
      const paper = papers[node.dataset.paper];
      if (!paper) return;
      hidePreview();
      activeNode = node;
      node.setAttribute('aria-describedby', preview.id);
      node.classList.add('is-previewing');
      preview.querySelector('[data-preview-title]').textContent = paper.title;
      preview.querySelector('[data-preview-authors]').textContent = paper.authors_short;
      preview.querySelector('[data-preview-venue]').textContent = [paper.year_label, paper.venue].filter(Boolean).join(' · ');
      preview.querySelector('[data-preview-topics]').textContent = paper.topics.map(id => topics[id].label).join(' · ');
      preview.hidden = false;
      positionPreview();
    };
    const scheduleHide = () => {
      clearTimeout(hideTimer);
      hideTimer = setTimeout(() => {
        if (!preview.matches(':hover') && !activeNode?.matches(':hover, :focus')) hidePreview();
      }, 120);
    };
    stage.addEventListener('pointerover', event => {
      if (event.pointerType === 'touch') return;
      const node = event.target.closest('.research-node');
      if (node) showPreview(node);
      if (event.target.closest('.paper-preview')) clearTimeout(hideTimer);
    });
    stage.addEventListener('pointerout', event => {
      const node = event.target.closest('.research-node');
      if (node && !node.contains(event.relatedTarget)) dismissedNode = null;
      scheduleHide();
    });
    stage.addEventListener('focusin', event => {
      const node = event.target.closest('.research-node');
      if (node) { dismissedNode = null; showPreview(node); }
    });
    stage.addEventListener('focusout', scheduleHide);
    document.addEventListener('keydown', event => {
      if (event.key === 'Escape' && !preview.hidden) {
        dismissedNode = activeNode;
        hidePreview();
      }
    });
    window.addEventListener('resize', positionPreview);
    controls.hidden = false;
    controls.addEventListener('click', event => {
      const button = event.target.closest('[data-lens]');
      if (!button) return;
      hidePreview();
      const topic = button.dataset.lens;
      lens.dataset.active = topic;
      controls.querySelectorAll('button').forEach(item => item.setAttribute('aria-pressed', String(item === button)));
      let selectedCount = 0;
      nodes.forEach(node => {
        const selected = topic === 'all' || node.dataset.topics.split(' ').includes(topic);
        node.classList.toggle('is-muted', !selected);
        if (selected) selectedCount += 1;
      });
      lens.querySelector('.lens-count').textContent = topic === 'all' ? `${nodes.length} works` : `${selectedCount} of ${nodes.length} works`;
      copy.textContent = topic === 'all' ? 'Hover or focus a point to explore. Select it to open the paper.' : `${selectedCount} works in ${topics[topic].label.toLowerCase()}. Explore the full topic.`;
      link.href = topic === 'all' ? allHref : `${allHref}?topic=${topic}`;
      link.setAttribute('aria-label', topic === 'all' ? 'Explore all publications' : `Explore ${topics[topic].label}`);
    });
  }

  const tools = document.querySelector('[data-publication-tools]');
  if (tools) {
    const taxonomy = JSON.parse(document.querySelector('#publication-taxonomy-data').textContent);
    const {normalize, createQueryMatcher} = window.PublicationSearch;
    const queryMatcher = createQueryMatcher(taxonomy);
    const search = document.querySelector('#publication-search');
    const year = document.querySelector('#publication-year');
    const topic = document.querySelector('#publication-topic');
    const tag = document.querySelector('#publication-tag');
    const description = document.querySelector('#publication-topic-description');
    const groups = [...document.querySelectorAll('.publication-year')];
    const entries = [...document.querySelectorAll('.bib_entry')].map(element => {
      const tags = element.dataset.tags.split(' ');
      const topics = element.dataset.topics.split(' ');
      const title = [element.querySelector('.bib-title').textContent, element.dataset.alternateTitle || ''].join(' ');
      const metadata = [...element.querySelectorAll('.bib-title, .bib-authors, .bib-venue, .bib-abstract p')].map(el => el.textContent);
      const tagNames = tags.flatMap(id => [taxonomy.tags[id].label, ...taxonomy.tags[id].aliases]);
      return {
        element, row: element.closest('li'), title: normalize(title), topics, tags,
        text: normalize([title, ...metadata, ...tagNames, ...topics].join(' ')),
        year: element.closest('.publication-year').dataset.year
      };
    });
    const count = document.querySelector('#publication-count');
    const empty = document.querySelector('.publication-empty');
    const buttons = [...document.querySelectorAll('[data-filter]')];
    const resets = [...document.querySelectorAll('[data-reset-publications]')];
    let filter = 'all';
    for (const group of groups) {
      const option = document.createElement('option');
      option.value = group.dataset.year;
      option.textContent = group.dataset.year;
      year.append(option);
    }
    const update = (historyMode = 'replace') => {
      const matchesQuery = queryMatcher(search.value);
      const matchesBase = item => {
        const data = item.element.dataset;
        return (filter === 'all' || data.type === filter || data[filter] === 'true') &&
          (year.value === 'all' || item.year === year.value) && matchesQuery(item);
      };
      let visible = 0;
      for (const item of entries) {
        const matches = matchesBase(item) && (topic.value === 'all' || item.topics.includes(topic.value)) &&
          (tag.value === 'all' || item.tags.includes(tag.value));
        item.row.hidden = !matches;
        if (matches) visible += 1;
      }
      for (const group of groups) group.hidden = ![...group.querySelectorAll('.bibliography > li')].some(row => !row.hidden);
      count.textContent = `${visible} of ${entries.length} works`;
      empty.hidden = visible !== 0;
      description.textContent = taxonomy.topics[topic.value]?.description || 'Browse by topic or a specific tag. Papers can belong to more than one topic.';
      for (const [select, field, other, otherField] of [[topic, 'topics', tag, 'tags'], [tag, 'tags', topic, 'topics']]) {
        for (const option of [...select.options].slice(1)) {
          const total = entries.filter(item => matchesBase(item) && item[field].includes(option.value) &&
            (other.value === 'all' || item[otherField].includes(other.value))).length;
          option.textContent = `${taxonomy[field][option.value].label} (${total})`;
          option.disabled = total === 0 && option.value !== select.value;
        }
      }
      buttons.forEach(button => button.setAttribute('aria-pressed', String(button.dataset.filter === filter)));
      const values = [['q', search.value.trim()], ['type', filter], ['year', year.value], ['topic', topic.value], ['tag', tag.value]];
      const active = values.some(([key, value]) => key === 'q' ? value !== '' : value !== 'all');
      resets.find(button => button.classList.contains('clear-publications')).hidden = !active;
      if (historyMode !== 'none') {
        const url = new URL(location.href);
        values.forEach(([key, value]) => {
          if (value && (key === 'q' || value !== 'all')) url.searchParams.set(key, value); else url.searchParams.delete(key);
        });
        const path = `${url.pathname}${url.search}${url.hash}`;
        if (path !== `${location.pathname}${location.search}${location.hash}`) history[historyMode === 'push' ? 'pushState' : 'replaceState'](null, '', path);
      }
    };
    const restore = () => {
      const params = new URLSearchParams(location.search);
      search.value = params.get('q') || '';
      for (const [select, key] of [[year, 'year'], [topic, 'topic'], [tag, 'tag']]) {
        const value = params.get(key);
        select.value = [...select.options].some(option => option.value === value) ? value : 'all';
      }
      filter = buttons.some(button => button.dataset.filter === params.get('type')) ? params.get('type') : 'all';
    };
    buttons.forEach(button => button.addEventListener('click', () => { filter = button.dataset.filter; update('push'); }));
    search.addEventListener('input', () => update());
    [year, topic, tag].forEach(select => select.addEventListener('change', () => update('push')));
    resets.forEach(button => button.addEventListener('click', () => {
      search.value = ''; year.value = 'all'; topic.value = 'all'; tag.value = 'all'; filter = 'all';
      update('push'); search.focus();
    }));
    document.querySelector('#publication-results').addEventListener('click', event => {
      const link = event.target.closest('[data-topic-link], [data-tag-link]');
      if (!link || event.ctrlKey || event.metaKey || event.shiftKey || event.altKey || event.button !== 0) return;
      event.preventDefault();
      history.pushState(null, '', link.href);
      restore(); update('none');
      tools.scrollIntoView({block: 'start'});
      (link.dataset.topicLink ? topic : tag).focus({preventScroll: true});
    });
    window.addEventListener('popstate', () => { restore(); update('none'); });
    restore();
    tools.hidden = false;
    update();
  }

  document.querySelectorAll('[data-back-top]').forEach(link => link.addEventListener('click', event => {
    event.preventDefault();
    window.scrollTo({top: 0, behavior: matchMedia('(prefers-reduced-motion: reduce)').matches ? 'instant' : 'smooth'});
    document.querySelector('.brand')?.focus({preventScroll: true});
  }));
})();
