/* Shared search semantics, also exercised by the Node regression tests. */
((root) => {
  'use strict';
  const normalize = value => String(value).toLocaleLowerCase().normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '').replace(/[^\p{L}\p{N}]+/gu, ' ')
    .replace(/\band\b/g, ' ').replace(/\s+/g, ' ').trim();

  const createQueryMatcher = taxonomy => {
    const aliases = [];
    // Specific tags win a same-length tie with a broad topic.
    for (const field of ['tags', 'topics']) {
      for (const [id, definition] of Object.entries(taxonomy[field])) {
        const names = new Set([id, definition.label, ...definition.aliases].map(normalize));
        for (const name of names) aliases.push({field, id, words: name.split(' ')});
      }
    }
    aliases.sort((a, b) => b.words.length - a.words.length);
    return query => {
      const words = normalize(query).split(' ').filter(Boolean);
      const exact = aliases.find(item => item.words.length === words.length && item.words.every((word, i) => words[i] === word));
      if (exact) return item => item[exact.field].includes(exact.id);
      const conditions = [];
      for (let position = 0; position < words.length;) {
        const alias = aliases.find(item => item.words.every((word, offset) => words[position + offset] === word));
        if (alias) {
          conditions.push(item => item[alias.field].includes(alias.id));
          position += alias.words.length;
        } else {
          const word = words[position++];
          conditions.push(item => item.text.includes(word));
        }
      }
      const phrase = words.join(' ');
      return item => (words.length > 1 && item.title.includes(phrase)) || conditions.every(condition => condition(item));
    };
  };
  const api = {normalize, createQueryMatcher};
  if (typeof module !== 'undefined' && module.exports) module.exports = api;
  else root.PublicationSearch = api;
})(typeof window !== 'undefined' ? window : globalThis);
