(() => {
  'use strict';
  const track = (name, parameters) => {
    if (typeof window.gtag === 'function' && window.soscdAnalyticsReady) window.gtag('event', name, parameters);
  };
  document.querySelectorAll('[data-copy-citation]').forEach(button => {
    const target = document.getElementById(button.dataset.copyCitation);
    const status = button.closest('section').querySelector('[data-copy-status]');
    if (!target || !status) return;
    button.hidden = false;
    button.addEventListener('click', async () => {
      button.disabled = true;
      try {
        await navigator.clipboard.writeText(target.textContent.trim());
        status.textContent = 'Citation copied.';
        track('citation_copy', {page_path: location.pathname});
      } catch {
        const range = document.createRange();
        range.selectNodeContents(target);
        const selection = window.getSelection();
        selection.removeAllRanges();
        selection.addRange(range);
        status.textContent = 'Citation selected. Use your browser’s Copy command.';
      } finally {
        button.disabled = false;
      }
    });
  });
  document.addEventListener('click', event => {
    if (event.target.closest('a[href^="mailto:"]')) {
      track('lab_contact', {page_path: location.pathname});
    }
    const link = event.target.closest('a[data-resource-type]');
    if (!link) return;
    track('research_resource_open', {
      resource_type: link.dataset.resourceType,
      publication_id: link.dataset.publicationKey || '',
      page_path: location.pathname
    });
  });
  // Track only explicit taxonomy choices, never the free-text publication query.
  document.querySelectorAll('#publication-topic, #publication-tag, #publication-year').forEach(control => {
    control.addEventListener('change', () => track('publication_filter', {
      filter_type: control.id.replace('publication-', ''), filter_value: control.value
    }));
  });
})();
