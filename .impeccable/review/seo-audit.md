# SOS+CD: search and AI discovery audit

Audited September 7, 2026. Live baseline: https://scienceofscience.org/ at commit `f4a9ff5`. Technical corrections described below are local, uncommitted, and not deployed.

> This is the pre-implementation audit. See [the implementation record](seo-implementation.md) for the current local changes and remaining account setup.

## Assessment

The site has a strong technical foundation: fast static HTML, readable publication records, functioning canonical URLs, and accessible research filters. Its largest opportunity is to turn its research into identifiable, useful sources that someone can discover, understand, cite, and reuse.

The publication list answers “What have you published?” It less often answers “What does your research tell us about this problem, and where can I inspect the evidence?” Dedicated paper pages, topic explanations, and documented datasets would bridge that gap for researchers and search assistants alike.

This plan prioritizes researchers seeking papers, methods, and datasets, with students, collaborators, and supporters as secondary audiences. It does not assume a particular search ranking or a measurable traffic increase. No authenticated Search Console, Bing Webmaster Tools, analytics, backlink, or crawl-log data was available.

## Live evidence

| Observation | What it means |
|---|---|
| All 14 HTML URLs in the sitemap returned 200 | No failed HTML landing pages in this sample. This is not proof that Google has indexed them. |
| 70 publication records, dated 2008–2026, are present in HTML | Researchers and text crawlers can read the catalog without executing JavaScript. Preserve this. |
| Only two individual paper landing pages | Most work lacks a dedicated explanatory page on the lab domain, although publisher and repository pages may already be indexed. |
| Every audited HTML page has a canonical and one H1 | Basic document structure is sound. HTTP and `www` requests also resolved to the preferred HTTPS host. |
| Topic/tag query URLs canonicalize to `/publications/` | Appropriate for overlapping filters. They are not substitutes for distinct research-topic landing pages. |
| Five pages reuse the generic 48-character lab-name description | Both paper pages, deadlines, undergraduate opportunities, and workshops lack a useful search summary. |
| All 14 pages have only an Organization JSON-LD stub containing a URL | The markup does not identify the organization by name, its university, the PI, papers, or datasets. |
| No Open Graph image on those 14 pages | Shared links lack a configured visual identity. This is a sharing issue, not evidence of a ranking penalty. |
| The longevity paper has year 2024, no citation authors, and no DOI | It disagrees with the 2025 published article and the bibliography. This can impair reliable citation extraction. |
| `/robots.txt` contains the sitemap and no blocking directives | No robots exclusion for Google, Bing, or OpenAI search was found. Actual crawler visits cannot be confirmed without logs. |
| `/feed.xml` is valid but contains no entries | The advertised subscription feed does not deliver the site's publication or news updates. |
| A 2020 internal deadlines page and old logo PDF appear in the sitemap | These are weaker search destinations than the research content. |
| Source config uses `UA-53191307-1` and legacy `ga.js` | The checked-in tracking configuration is Universal Analytics, not a current GA4 setup. |

The summer-school URL `/s4/` is a redirect page to the separate school site, which explains its absence from the canonical-page sitemap. It should not be counted as a missing research page.

The longevity article was published May 22, 2025, with five authors and DOI `10.1057/s41599-025-04716-z`. The published PDF was also reachable during the audit. [Publisher record](https://www.nature.com/articles/s41599-025-04716-z).

Universal Analytics was shut down in 2024; a legacy ID cannot provide the current measurement baseline this work needs. Existing Google account configuration was not inspected. [Google's migration notice](https://blog.google/products/ads-commerce/google-analytics-360-ga4-update/).

## Performance and browser usability

Lighthouse 13.4.1, one live run per page, simulated mobile device and throttling:

| Page | Performance | Accessibility | Best practices | Technical SEO | LCP | Blocking time | Layout shift |
|---|---:|---:|---:|---:|---:|---:|---:|
| Home | 100 | 100 | 100 | 100 | 1.4 s | 0 ms | 0 |
| Publications | 100 | 100 | 100 | 100 | 1.5 s | 0 ms | 0 |

These are lab measurements, not real-user Core Web Vitals, a full accessibility audit, or a ranking/AI-citation score. A 100 score does not mean there is nothing to improve: Lighthouse's unscored/experimental label check found two accessible-name mismatches. The brand text ran together as `SOS+CDLab`, while its accessible name contained a space; the visible “Ecosystem” button was named only “Science of science” for assistive technology.

Other lower-priority opportunities are responsive portrait variants (about 101 KiB estimated savings on the homepage) and a smaller publication thumbnail (about 58 KiB on the archive). The observed ten-minute cache lifetime is a hosting consideration. Do not move the site or complicate the CSS delivery merely to chase these diagnostics while the main pages already load quickly.

## Priority roadmap

Impact below is an informed prioritization, not an experimentally measured ranking effect. Effort estimates are engineering effort; paper reading and author review add time.

| Priority | Work | Expected value | Effort / dependency |
|---|---|---|---|
| 1 | Establish Search Console, Bing, and current site analytics | Know which pages are discovered, cited, visited, and useful | About half a day; account access and a valid measurement ID |
| 1 | Correct citation metadata and describe the lab's identity | Reduce ambiguity and factual extraction errors | Local foundation prepared in this task |
| 1 | Publish 10–15 substantive paper pages, then expand | Give important work a stable, citable home | Reusable template plus paper-by-paper evidence review |
| 1 | Create three main research hubs, with a fourth if useful | Answer topic-level questions and connect related work | Several days including writing and review |
| 2 | Turn mentorship into a documented dataset landing page | Help people find, understand, download, and cite the resource | One to two days plus dataset review |
| 2 | Generate publication exports and a real news/research feed | Support reference managers, subscriptions, and agents | Approximately one to two days |
| 2 | Connect institutional, author, repository, and publication pages | Make ownership and provenance easier to verify | Editorial coordination; no unsolicited outreach sent |
| 3 | Add a designed sharing card and responsive image variants | Better previews and smaller transfers | Small visual/asset task |
| 3 | Experiment with optional agent convenience formats | Test practical reuse, without assuming a ranking boost | Only after useful content and measurement exist |

### Paper pages: the most valuable content investment

Start with representative work on image integrity, peer review, scientific resources, mentorship, and collaboration, selected for relevance and available evidence rather than citation counts alone. Keep the user's 2008 cutoff. Do not generate 70 title-and-abstract shells simply to increase page count.

Each page should contain:

1. Exact title, authors in order, publication status, date, venue, and DOI or other persistent identifier.
2. A short explanation of the research question and what the study found, reviewed against the actual paper.
3. The complete authorized abstract; then methods, scope, and limitations where helpful.
4. Clearly distinguished published version, preprint, code, dataset, and working demo links.
5. A ready-to-copy citation and BibTeX download.
6. Related papers and a link to the relevant research topic.

Generate repeated metadata from a shared publication record to prevent the catalog, paper page, citation tags, and JSON-LD from drifting apart. Preserve existing paper URLs. Avoid representing older work by current lab members as having been conducted by the present lab unless that is historically accurate.

Google Scholar has its own requirements: an individual paper URL, accessible scholarly content or a complete abstract, and reliable citation title/author/date metadata. Its guidelines also specify how an HTML abstract should link to a corresponding PDF, including a same-subdirectory condition. The present PDF links use another path or host, so local full-text hosting merits a separate rights-and-eligibility review. Markup alone cannot guarantee Scholar inclusion. [Google Scholar inclusion guidelines](https://scholar.google.com/intl/en/scholar/inclusion.html).

### Research hubs: use the taxonomy to explain the work

Keep the current overlapping topics and tags for filtering. Build substantive pages for:

| Proposed page | Reader questions | Content to connect |
|---|---|---|
| `/research/research-integrity/` | How can computational methods assess scientific images, reporting, and resource availability? | Image-forensics work, integrity benchmarks, reproducibility, resource longevity |
| `/research/peer-review-discovery/` | How can we evaluate AI-assisted review and find relevant research? | Review evaluation, recommendation methods, discovery tools; distinguish their actual tasks |
| `/research/science-of-science/` | How do mentorship, teams, incentives, and careers shape science? | Mentorship dataset, collaboration, recognition, funding, diversity research |
| A methods/cognition page, if it supports current goals | Which methodological foundations inform this work? | Relevant older work, with historical context |

Each hub needs an explanation of the problem, the lab's approach, what its papers support, open questions, and selected resources. Link the research navigation to a clear research overview while keeping funding and support as distinct destinations. At present “Research” leads to `/funding/`; the existing URL can remain as a grant page when the research section grows.

Do not make every tag, year, and filter combination indexable. Query filtering relies on JavaScript; a text-only request sees the full archive. A topic page provides its intended explanation directly in HTML, while the archive remains a useful interactive tool.

### Dataset discovery: build on the mentorship resource

The Zenodo record identifies a June 9, 2021 dataset release, DOI `10.5281/zenodo.4917086`, with five creators and a CC BY 4.0 license. This is distinct from the related 2022 journal article. It includes mentorship, researcher, authorship, paper, demographic-estimation, and embedding files, with widely varying download sizes. [Zenodo record](https://zenodo.org/records/4917086).

Improve `/mentorship/` with the dataset's purpose, coverage, field definitions, file sizes, a small download-and-join example, version/date, citation, license, and known limitations. Explain how estimated gender/race fields should and should not be interpreted; review this wording against the paper and documentation. Avoid presenting inferred demographics as verified personal attributes.

Add `Dataset` JSON-LD that matches this visible documentation. Google's dataset guidance calls for a name and substantive description and recommends details such as creators, license, identifiers, and distributions. A `DataDownload.contentUrl` must point to the file, not merely the Zenodo landing page. [Google Dataset guidance](https://developers.google.com/search/docs/appearance/structured-data/dataset).

## ChatGPT and other AI systems

Think about three separate outcomes: appearing in search results, being cited in an answer, and letting an agent complete a task on the site. They overlap, but should be measured separately.

**Search access.** OpenAI distinguishes `OAI-SearchBot` for search from `GPTBot` for model training. Allowing search does not require allowing training. `ChatGPT-User` is associated with user-initiated visits and is not the control for automatic search inclusion. No robots change is needed to remove a current search block here. If a CDN or firewall is added later, check its treatment of the documented crawlers. [OpenAI crawler documentation](https://developers.openai.com/api/docs/bots).

**Citable content.** My recommendation is to provide precise, attributable explanations with dates, methods, limitations, and links to the underlying evidence. This makes the site more useful as a source; it does not establish a guaranteed ChatGPT ranking formula. Preserve disagreements, uncertainty, and preprint status instead of flattening them into promotional claims.

**Agent actions.** A researcher should be able to ask an agent to find a paper, identify the published version, copy a citation, and retrieve a dataset. Keep native links, labeled controls, visible selected states, stable URLs, and accessible names. Descriptive links such as “Download the published paper (PDF)” are easier to interpret than “click here.” Keep essential information in the page, rather than requiring hover. [Agent-friendly website guidance](https://web.dev/articles/ai-agent-site-ux).

**Machine-readable conveniences.** Generate `/publications.json` and a public BibTeX export from the same source as the archive. Suggested fields are ID, title, ordered authors, dates, publication status, DOI, local page, topic IDs, tags, and clearly typed resource links. Do not include nonexistent resources or fabricate abstracts. A working Atom/RSS feed can expose genuinely new papers and lab news.

**What not to prioritize.** Google's AI search guidance says ordinary crawlability and useful content remain relevant; no special AI markup is required. Its current optimization guide explicitly says Google ignores `llms.txt`. A concise `llms.txt` could be an optional navigation experiment for tools that choose to read it, but it is not a demonstrated Google or ChatGPT ranking improvement. Also avoid keyword-stuffed FAQ pages, hidden bot-only claims, manufactured mentions, or a chatbot/MCP server without a real task to support. [Google AI search requirements](https://developers.google.com/search/docs/appearance/ai-features), [Google AI optimization guide](https://developers.google.com/search/docs/fundamentals/ai-optimization-guide).

## Authority and useful next actions

Keep the lab name, affiliation, PI identity, and canonical links consistent across the lab site, CU faculty page, PI website, ORCID, Scholar, GitHub, Zenodo, and publication repositories. The CU profile already links to the lab, which is a useful foundation. Distinguish the lab's profiles from Daniel's personal profiles. Do not change historical paper affiliations to current ones. [CU faculty profile](https://www.colorado.edu/cs/daniel-acuna).

Research visibility should lead somewhere useful: a relevant paper, documented dataset, usable code repository, current opening, or clear collaboration contact. The support page should continue to explain the actual giving process; a direct donation action can be added when the named CU lab fund and designation link are confirmed.

## Measurement and evaluation

| Surface | What to examine | What it cannot establish alone |
|---|---|---|
| Google Search Console | Sitemap processing, URL inspection, indexed canonical pages, relevant query impressions/clicks | Whether a particular content edit caused a ranking change |
| Search Console's Generative AI performance report | AI Overview / AI Mode impressions by page and other available dimensions | A complete count of ChatGPT citations or downstream visits |
| Bing Webmaster Tools AI Performance | Citations and cited pages within the report's supported AI surfaces | Universal visibility across every assistant |
| GA4 or another current analytics tool | Search/AI referrals and useful outbound actions | All AI exposure, especially answers that cause no click |
| Small repeatable prompt/task sample | Citation accuracy, version selection, resource retrieval, agent completion | A stable or representative overall “AI rank” |

Google says its Generative AI report rolled out globally on August 31, 2026. It measures impressions for supported Google AI search experiences; availability and useful breakdowns depend on the property's data. [Search Console AI report documentation](https://support.google.com/webmasters/answer/16984139).

Bing's AI Performance reporting covers citations in Microsoft Copilot, Bing AI summaries, and selected partner experiences. Citation counts should not be equated with referral traffic or a universal ChatGPT position. [Bing AI Performance announcement](https://blogs.bing.com/webmaster/February-2026/Introducing-AI-Performance-in-Bing-Webmaster-Tools-Public-Preview).

Establish a baseline before publishing the next content batch. Track important local pages and branded versus research-topic queries over subsequent 28- and 90-day windows. Record deployment dates and account for publication/news events, small samples, and search-system changes. For manual AI checks, retain the exact prompt, date, model/product, and cited URLs; judge factual accuracy and useful citations rather than just lab mentions.

Suggested outcomes are paper/DOI visits, dataset downloads, code visits, and relevant contact or recruiting actions. Do not send free-text publication searches into analytics by default: they may contain names or other personal information, and aggregate filter/resource events are usually sufficient.

## Local corrections prepared and verified

- Added meaningful site/page descriptions, shorter page-title branding, a specific historical workshop title, and a fallback sharing image using the restored diamond logo.
- Added connected `ResearchOrganization`, university, `Person`, `WebSite`, and `WebPage` entities, plus `ScholarlyArticle` on the two existing paper pages. These describe known public facts, not unsupported awards, ratings, or rankings.
- Corrected the longevity paper's year, complete author list, publication date, journal, volume, DOI, and published-PDF link. Distinguished its earlier preprint in the visible links.
- Escaped citation metadata attributes and supported correctly spelled author-affiliation metadata alongside the legacy spelling.
- Marked the internal deadlines page `noindex, follow` and removed it from the sitemap. Removed the old logo PDF from the sitemap, without deleting the file or claiming that sitemap removal deindexes it.
- Fixed the two accessible-label mismatches.

Validation: production Jekyll build passed; new metadata checks passed with 4 tests and 206 assertions; existing publication taxonomy validation and all 8 search tests passed. Desktop and mobile inspection found no horizontal overflow on the corrected paper page. Browser checks found the expected brand name and research button; the integrity search still showed 18 of 70 works. Production canonicals were verified separately from the development server's local canonicals.

The local server is available at http://127.0.0.1:4000/. These changes have not been pushed. Dataset schema, new research/paper pages, feeds, exports, current analytics, and account-level indexing checks remain roadmap work; they are not claimed as completed.

## Evidence files

- [Live crawl before changes](seo-live-audit.json): statuses, titles, descriptions, canonicals, headings, structured data, citation tags, links, and images for the 14 sitemap HTML pages.
- [Live Lighthouse results](seo-lighthouse-summary.json): configurations, timestamps, scores, metrics, and diagnostic findings for home and publications.
- [Desktop inspection](seo-paper-desktop.png) and [mobile inspection](seo-paper-mobile.png) of the locally corrected paper page.
- Regression checks: `tests/seo_test.rb`. Run with `bundle exec ruby tests/seo_test.rb /tmp/soscd-seo-production` after a production build to that destination.
