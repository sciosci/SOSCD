# Maintaining research publishing and discovery

Implemented September 7, 2026. Production origin: `https://scienceofscience.org`. The site is static Jekyll; normal builds do not contact metadata services. Changes in this implementation remain local until published.

## Content ownership

| Source | Owns |
|---|---|
| `_bibliography/references.bib` | Titles, ordered authors, dates, venues, DOI, publisher/preprint/code/data URLs |
| `_data/publication_taxonomy.yml` | Explicit, overlapping topic and tag assignments; publication format |
| `_data/publication_details.yml` | Selected paper paths, original explanatory summaries, methods, findings, limitations, source checks, authorized abstracts and licenses |
| `_data/paper_pdf_sources.yml` | Reviewed PDF source, license, local path, size and original-byte SHA-256 |
| `_data/research_topics.yml` | Four explanatory topic hubs and their selected publications |
| `_data/datasets.yml` | Dataset release facts, creators, license, file names, sizes, checksums, URLs and verified CSV columns |
| `news.yml` | News copy, stable entry IDs and update timestamps |
| `_data/research_updates.yml` | Last substantive publication-catalog update timestamp |

The generators own `_data/publication_index.yml`, `_data/publication_order.yml`, `_data/publication_lens.yml`, facets, statistics, featured works, individual paper front matter, BibTeX downloads, archive year groups, and news views. Edit the sources above, then regenerate. Do not hand-edit generated paper front matter: it will be replaced.

## Add or revise a paper

1. Add the verified bibliographic record and explicit taxonomy. The catalog rejects papers before 2008, missing taxonomy, invalid IDs/formats and colliding citation-download paths.
2. Check the publisher or repository for the correct version, ordered authors, DOI, and date. Keep a year-only date when a full date is not verified. Distinguish a published article from its preprint.
3. For a substantive overview, add a record to `publication_details.yml` with a unique stable path, research question, short original summary, findings, methods, limitations, source URL and review date. An overview should explain the actual evidence, including uncertainty. It is optional for other archive records.
4. Reproduce a full abstract only when its reuse is authorized; preserve the wording and record its license. Otherwise write an original concise summary and link to the original abstract. Do not infer a license merely because the work can be read online.
5. Add available source/code/data URLs to the bibliography. For a local PDF, record the specific redistribution license and source in `paper_pdf_sources.yml`. Keep original bytes, retain attribution, and keep the PDF in the paper page's directory. Files over 5 MB remain external under the current hosting policy.
6. Update `_data/research_updates.yml` after a substantive catalog change, then run the build and checks below. Ordinary rebuilds must not refresh every feed entry's date.

The two established `.html` paper URLs remain unchanged. New overviews use `/publications/<slug>/`. The first batch contains 15 overviews, 13 authorized full abstracts and 10 local PDFs. That improves the available scholarly content; it does not guarantee Google Scholar indexing. Two summaries link to abstracts without reproducing them because no Creative Commons license was verified.

`lib/fetch_research_metadata.py` caches public Crossref, publisher, arXiv, Europe PMC and Zenodo records in the ignored `.impeccable/research/seo-sources/` directory. `lib/prepare_research_sources.rb` is an editorial importer for this reviewed batch, not a build step. Inspect imported differences before accepting them. `python3 lib/fetch_research_metadata.py --pdfs` reproduces the reviewed PDF manifest; it preserves cached local originals and reports unavailable/oversize sources rather than substituting unrelated files. Publisher 403 responses are not bypassed.

## Feeds and exports

- `/publications.json`: all archive records, ordered authors, identifiers, topics, tags, available summaries/abstracts, original source and typed resource links. Missing local overviews are explicitly `null`.
- `/publications.bib` and `/publications/citations/<key>.bib`: complete and individual bibliography downloads, generated from the same records.
- `/publications/feed.xml`: publication catalog updates. An entry's update timestamp means the catalog was updated; full publication dates appear only when verified.
- `/feed.xml`: real lab news. Stable news IDs survive copy corrections; update an entry's `updated_at` when its substance changes. New entries receive an ID and ingestion timestamp once. Event dates remain visible as event dates, including future announcements.
- `/datasets/mentorship.json` and `/datasets/mentorship.bib`: the specific 2021 dataset release, distinct from its 2022 paper.
- `/llms.txt`: an experimental navigation index to ordinary public pages and exports. It contains no hidden factual claims or bot-specific instructions. No ranking benefit is assumed.

Keep query-based publication filters canonicalized to `/publications/`. Their overlapping combinations are controls, not separate landing pages. Use substantive topic hubs for distinct indexable explanations. The archive remains fully readable without JavaScript; copy buttons progressively enhance selectable citations and ordinary download links.

## Google Analytics and the existing Search Console property

The old `UA-53191307-1` configuration was Universal Analytics. On September 7, 2026, the signed-in Chrome session confirmed the existing `scienceofscience` account (53191307) had no GA4 property. The lab now has property **SOS+CD Lab — scienceofscience.org** (552893037), website stream **SOS+CD Lab website** (15736506497), and Measurement ID **G-P91ZSLM4VH**, configured in `_config.yml`. Reporting uses Denver time and USD, with traffic and engagement reports. Daniel's separate `acuna.io` property is unchanged.

Production builds load `gtag.js` only when a `G-…` ID is configured. Development builds do not collect analytics. The GitHub workflow now sets `JEKYLL_ENV=production`, so a configured ID can load after deployment. A production fixture with a test ID was evaluated without making analytics requests.

The implementation provides these events when GA4 is active:

| Event | Information |
|---|---|
| `research_resource_open` | Resource type (overview, paper, PDF, preprint, code, dataset, demo, citation), publication key when present, page path |
| `citation_copy` | Page path after a successful copy |
| `publication_filter` | Explicit topic/tag/year selection; no free-text query |
| `lab_contact` | Page path when a mail link is chosen; no message contents |

Page-location and same-origin referrer overrides remove the free-text `q` parameter and fragments, while retaining referral/UTM and taxonomy information. Advertising personalization and Google signals are disabled in the tag configuration. The web stream has Enhanced Measurement **Site search**, **Form interactions**, and history-based page changes disabled; normal page loads, scrolls, outbound clicks, video engagement and file downloads remain enabled. This avoids collecting archive searches and counting filter URL updates as page views. Email redaction remains enabled, and `q` URL parameter redaction is also configured in GA4. Avoid installing a second tag through GTM or another integration.

Account follow-up steps:

1. The GA4 property, website stream and Measurement ID are confirmed. Verify production page views and the events above in Realtime/DebugView after publishing.
2. Link the existing Search Console property to the appropriate GA4 web stream, if not already linked. Review access and property matching within the accounts.
3. Use the existing Search Console property to confirm `/sitemap.xml` processing and inspect representative new topic, paper and dataset URLs after deployment. Do not create a duplicate property simply for this change.
4. If desired, import/verify the same site in Bing Webmaster Tools and submit the sitemap. Its AI Performance reporting and Search Console's supported AI reports supplement referral analytics; they do not measure every ChatGPT citation.
5. Create useful reports for resource actions and referrals, including `chatgpt.com`, other assistants and ordinary organic search. Record a baseline and deployment date, then compare 28- and 90-day windows with publication/news activity in mind.

The lab Analytics property and stream were created in the existing account. Search Console verification, Bing property, indexing requests, external profiles and university giving accounts were not changed by this setup. Public CU/ORCID/Scholar identity links were added to the PI page. A direct lab-giving button still requires the confirmed CU fund and designation link.

Official references: [GA4 event collection](https://developers.google.com/analytics/devguides/collection/ga4/events), [Google Scholar inclusion](https://scholar.google.com/intl/en/scholar/inclusion.html), [Dataset structured data](https://developers.google.com/search/docs/appearance/structured-data/dataset), [OpenAI crawler roles](https://developers.openai.com/api/docs/bots), [Google AI search guidance](https://developers.google.com/search/docs/fundamentals/ai-optimization-guide).

## Build and verification

```sh
npm test
JEKYLL_ENV=production npm run build
bundle exec ruby tests/seo_test.rb
```

While the development watcher runs, build to a separate destination to keep its local canonicals from replacing the production output:

```sh
JEKYLL_ENV=production bundle exec jekyll build --destination /tmp/soscd-seo-production
bundle exec ruby tests/seo_test.rb /tmp/soscd-seo-production
```

The GitHub workflow performs these publication/search/SEO checks and stops before deployment when they fail. Do not commit the locally generated `Gemfile.lock` from a different Ruby runtime; the existing repository ignores it. Current local Ruby is 4.0.6; the existing GitHub runtime is Ruby 3.0. Local passing checks are not a claim that this unpushed revision has run on GitHub.

The production checks cover canonical/title/description/social metadata, connected JSON-LD, author/date/DOI consistency, authorized abstracts, original PDF hashes, all BibTeX/JSON exports, nonempty valid Atom feeds, topic links/counts, dataset release facts, and internal links/fragments. Browser checks cover desktop/mobile layouts, citation copying/fallback, filtering and no-JavaScript access.

CSV column names were read from the four actual compressed files. After network retries, both small core tables downloaded and the complete join was verified with Python standard-library CSV processing: 774,733 researcher rows, no duplicate researcher IDs, and all 743,176 mentorship rows matched a mentee. The pandas example passed Python syntax validation; pandas itself is not installed in this environment. Repeat `python3 lib/fetch_research_metadata.py --verify-quickstart` to check the complete data. The large embedding matrices are never downloaded by this check.

Keep visual asset provenance with its files. `social-card.png` uses the original diamond and local fonts; responsive WebP variants retain the original lab photographs. See `seo-asset-manifest.md` under `.impeccable/review/`.

### September 7 follow-up: reporting and expanded overviews

The existing Search Console domain property is now linked to the lab stream, the current HTTPS sitemap reports Success, and the integrity hub's indexing request was accepted. The older pending-account steps above describe the initial setup; [the visibility review runbook](../../docs/visibility-review.md) records the current configuration. Bing and CU donations remain deferred by the user.

GA4 now has a Lab visibility overview as its Reports snapshot, a published Lab research collection containing Research engagement, four event-scoped research dimensions, and a launch annotation. Citation-copy events now include the publication key after a successful clipboard write. The account baseline is saved locally under the gitignored `.impeccable/research/analytics/` directory, separate from the public website.

Eight additional primary-source overviews bring the total to 23. Optional `reuse` and `reuse_source_url` fields add practical guidance within the existing paper template. These do not change the visual design system. The 70-paper archive and 2008 cutoff remain intact. The former `/en/` address redirects to the homepage. A monthly GitHub workflow audits public deployed pages and provides the review dates; account exports remain a signed-in review step.
