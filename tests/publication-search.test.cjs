const {test} = require('node:test');
const assert = require('node:assert/strict');
const {execFileSync} = require('node:child_process');
const {normalize, createQueryMatcher} = require('../assets/js/publication-search.js');
const source = JSON.parse(execFileSync('bundle', ['exec', 'ruby', '-rjson', '-ryaml', '-e',
  'puts({index: YAML.safe_load(File.read("_data/publication_index.yml")), facets: YAML.safe_load(File.read("_data/publication_facets.yml"))}.to_json)'
], {encoding:'utf8'}));
const records = Object.values(source.index).map(record => ({...record,
  title: normalize([record.title, record.alternate_title].join(' ')),
  text: normalize([record.title, record.alternate_title, record.authors, record.venue, record.year, ...record.topics,
    ...record.tags.flatMap(id => [source.facets.tags[id].label, ...source.facets.tags[id].aliases])].join(' '))
}));
const match = createQueryMatcher(source.facets);
const keys = query => records.filter(match(query)).map(record => record.key).sort();
const integrity = ['meguimtsop2026sciintbench', 'zhou2026widespread', 'acuna2022predicting',
  'zhuang2025estimating', 'zhuang2023computational', 'acuna2022', 'zhuangacuna2021',
  'zeng2020modeling', 'zhuangacuna2020', 'liangacuna2020', 'liang2020don', 'zeng2019dead',
  'acuna2018bioscience', 'teplitskiy2018sociology', 'xiang2020tampering', 'acuna2020nullmodel',
  'acuna2020mentorshipcommentary', 'abatayo2026credibility'].sort();
const peerReview = ['taechoyotin2026remctx','taechoyotin2025remor','taechoyotin2024mamorx',
  'acuna2022','teplitskiy2018sociology'].sort();

test('integrity includes papers whose titles do not contain integrity', () => {
  assert.deepEqual(keys('integrity'), integrity);
  assert.deepEqual(keys('Research integrity'), integrity);
});
test('combined discovery label means the complete broad topic', () => {
  const expected = records.filter(record => record.topics.includes('discovery')).map(record => record.key).sort();
  assert.equal(expected.length, 24);
  for (const label of ['peer review & discovery','Peer-review and computational discovery','discovery']) {
    assert.deepEqual(keys(label), expected);
  }
  assert.ok(expected.includes('taechoyotin2024misti'));
  assert.ok(expected.includes('achakulvisut2016science'));
});
test('peer review excludes a survey review and an unrelated journal name', () => {
  for (const label of ['peer review','peer-review','review','reviewers']) assert.deepEqual(keys(label), peerReview);
  assert.ok(!keys('review').includes('lee2019limiting'));
  assert.ok(!keys('review').includes('zhou2022paraphrase'));
});
test('tag synonyms distinguish image reuse from graphical integrity', () => {
  assert.deepEqual(keys('image manipulation'), ['acuna2018bioscience','acuna2020nullmodel','xiang2020tampering']);
  assert.deepEqual(keys('misleading graphs'), ['zhuangacuna2020','zhuangacuna2021']);
  assert.deepEqual(keys('predatory journals'), ['liang2020don','liangacuna2020','zhuang2025estimating']);
});
test('topic queries combine with author and year terms', () => {
  assert.deepEqual(keys('peer review 2024'), ['taechoyotin2024mamorx']);
  assert.deepEqual(keys('integrity Zhuang'), ['acuna2022predicting','zhuang2023computational','zhuang2025estimating','zhuangacuna2020','zhuangacuna2021']);
  assert.equal(keys('integrity peer review').length, 2);
});
test('title phrases are not swallowed by ambiguous topic words', () => {
  assert.deepEqual(keys('science concierge'), ['achakulvisut2016science']);
  assert.deepEqual(keys('comparative explanations for recommendation'), ['varasteh2024comparative']);
  for (const paper of Object.values(source.index)) assert.ok(keys(paper.title).includes(paper.key), paper.key);
  assert.deepEqual(keys('Dataset Mention Extraction in Scientific Articles Using Bi-LSTM-CRF Model'), ['zeng2020finding']);
  assert.deepEqual(keys('High-Reproducibility and High-Accuracy Method for Automated Topic Classification'), ['lancichinetti2015topic']);
});
test('accent normalization, empty search, and unmatched search', () => {
  assert.deepEqual(keys('Acuña'), keys('Acuna'));
  assert.equal(keys('').length, 70);
  assert.equal(keys('   ').length, 70);
  assert.equal(keys('no-such-publication-xyz123').length, 0);
});

test('preprints use actual years and excluded Scholar records do not appear', () => {
  assert.deepEqual(keys('peer review 2025'), ['taechoyotin2025remor']);
  assert.equal(records.filter(paper => paper.year === '2050').length, 0);
  assert.equal(records.filter(paper => Number(paper.year) < 2008).length, 0);
  assert.equal(keys('Effects of same-race mentorship preferences on academic performance and survival').length, 0);
  assert.equal(keys('Data Butler').length, 0);
});
