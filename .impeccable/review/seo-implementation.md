# SEO and AI-discovery implementation

September 7, 2026. These changes are local and have not been pushed or deployed. The earlier [audit](seo-audit.md) remains the live baseline, not a description of this implementation.

## Implemented

| Surface | Local result |
|---|---|
| Paper explanations | 15 substantive overviews, preserving the two previous URLs; 13 licensed full abstracts; question, findings, methods, limitations, citation and typed resources |
| Research topics | Four explanatory hubs plus `/research/`; archive topic counts and selected work come from the reviewed catalog |
| Scholarly content | Ten unchanged licensed PDFs hosted beside their paper pages, with attribution and recorded SHA-256; other papers retain external source links |
| Dataset | Rewritten mentorship guide with release/version distinction, five creators, license, four verified CSV schemas, documented joins and 22 files with sizes/checksums |
| Exports | 70 individual BibTeX files, complete BibTeX and JSON catalog, dataset JSON/BibTeX, all retaining the 2008 cutoff |
| Subscriptions | News feed with 68 entries and publication feed with 70 records, stable IDs and honest update/publication dates |
| Search metadata | Descriptions, canonical URLs, social metadata, connected lab/university/PI/site/page entities, ScholarlyArticle, Dataset and breadcrumbs |
| Links and navigation | Research now leads to research topics; code/data/citations have a resource index; PI page links CU, ORCID and Scholar |
| Images | 1200×630 social card using the original diamond, eight responsive portrait variants and two publication thumbnails |
| Analytics | GA4 provider and resource/citation/filter/contact events prepared; no active tag until a confirmed `G-…` ID is supplied |
| Agent access | Ordinary server-rendered pages and downloads, selectable/copyable citations, JSON/BibTeX and optional `llms.txt` navigation |
| Publishing | GitHub workflow builds in production mode and fails before deployment on publication/search/SEO test errors |

The full archive remains 70 records from 2008 onward. Integrity returns 18 works and peer review/discovery returns 24, including papers whose titles do not contain those terms. The new indexable HTML count is 32, compared with 14 on the audited live site; the old internal deadlines page is now excluded from indexing and the sitemap.

## Sources and editorial decisions

Consensus was used to discover and cross-check candidate work, then primary records supplied the verified metadata. Public Crossref, arXiv, ACL Anthology, publisher/Europe PMC records and Zenodo were checked. Source URLs and abstract licenses are retained in `_data/publication_details.yml`; PDF sources, rights and hashes are in `_data/paper_pdf_sources.yml`.

Notable corrections: the 2010 structure-learning article was not dated from a conflicting secondary 2008 search result; the longevity article is the five-author May 22, 2025 version, with its earlier preprint linked separately; the mentorship dataset's 2021 release is distinguished from its 2022 data descriptor; the questionable-journals paper uses the August 27, 2025 online publication date. Preprints remain labeled as preprints. Screening scores are not presented as findings of misconduct, and observational associations are not rewritten as causal effects.

Full abstracts were reproduced only where a Creative Commons license was verified. The image-reuse null-model and scientific-image-tampering pages have original summaries and links to their original abstracts. Of the 13 reviewed open PDF sources, two publisher endpoints returned 403 and one PDF exceeded the 5 MB local-hosting limit; these remain external. Ten originals, totaling about 21 MB, are hosted unchanged with attribution.

## Ph.D. application copy revision

At the user’s request, `/openings/` is the general **Join Us** page, with an objective Ph.D. application section alongside student and visiting-scholar information. The navigation and footer retain **Join Us**; the homepage Ph.D. link targets the dedicated section. Fixed-position and Fall 2027 advertisements were removed from the active application flow; current requirements, deadlines and funding information link to the official CU Boulder program pages. The lab’s policy against individual Ph.D. application inquiries to the PI is retained, with graduate admissions as the appropriate process contact. The original URL remains stable.

## Verification

- Production Jekyll build passed to `/tmp/soscd-seo-implementation`.
- SEO suite: 12 tests, 2,027 assertions, no failures/errors. All 32 canonical HTML pages, internal links/fragments, 15 paper records, exported citations, both feeds, the dataset schema and local PDF hashes were checked.
- Existing publication taxonomy checks and all eight search tests passed.
- Regeneration was deterministic: 107 generated/source files stayed byte-identical on a repeated generator run.
- Browser checks: clipboard success and denied-access fallback, correct integrity/discovery counts, all 70 records without JavaScript, no page errors, expected taxonomy analytics event.
- GA4 test configuration emitted the correct production tag; its inline setup was evaluated without network requests. Free-text queries were removed from page and same-site referrer URLs; UTM information remained. The normal build emits no GA4 tag while the Measurement ID is empty.
- Desktop 1280×900 and mobile 390×844 checks covered eight representative surfaces. No horizontal document overflow or broken images was found. Primary-button contrast and missing topic counts were corrected in one batch. The browser's malformed full-height archive captures were replaced with normal viewport segments.
- The design detector used its documented regex fallback because optional HTML parser modules were unavailable. It reported 26 advisory type-ramp entries and no mechanical findings; this is not a computed accessibility or contrast audit. The independent Impeccable finish review returned **ship**, with no material fixes, for the supplied representative surfaces; see `seo-finish-review.md` for its scope.

CSV columns were read from the actual files. After retrying outside the network sandbox, the complete two-table join passed: 774,733 unique researcher IDs and all 743,176 mentorship rows matched. The check used Python standard-library CSV processing; the displayed pandas example passed syntax validation but was not executed with pandas, which is not installed. See `seo-dataset-verification.json`.

## Account work still needed

The user already uses Search Console. No authenticated Analytics/Search Console/Bing session was accessible. The old repository value was Universal Analytics, not a GA4 ID. A concise question requesting the confirmed `G-…` Measurement ID remains pending. Do not describe tracking, dashboard linking, sitemap submission or indexing as completed.

After publishing, verify the sitemap and representative new URLs in the existing Search Console property, verify GA4 collection after configuring the ID, and record the deployment date. The [maintenance guide](../decisions/research-publishing.md) covers those steps and the ongoing content workflow. The [AI task benchmark](ai-discovery-benchmark.json) supplies repeatable prompts and expected evidence; it contains no fabricated AI ranking or citation results.

No ranking increase, Google Scholar inclusion, Search Console indexing, ChatGPT citation, or real-user performance improvement has been claimed. The previous live Lighthouse measurements are baseline evidence; this implementation was not re-scored with Lighthouse.
