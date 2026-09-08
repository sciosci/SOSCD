# Lab visibility and research engagement

Use the **SOS+CD Lab — scienceofscience.org** GA4 property (552893037), not Daniel's personal acuna.io property. The web stream uses `G-P91ZSLM4VH`. Collection began September 7, 2026; that day includes setup visits. There is no historical GA4 baseline for the redesigned lab site.

## Reports configured September 7, 2026

- **Reports → Reports snapshot** is the **Lab visibility overview** dashboard: engagement, events, acquisition sources, page views, Google queries and Google landing-page impressions.
- **Reports → Lab research → Visibility and engagement → AI referrals** filters known AI assistant source domains and shows sessions, engaged sessions, engagement rate, engagement time and event counts by Session source / medium.
- **Reports → Lab research → Visibility and engagement → Research engagement** isolates `research_resource_open`, `citation_copy`, `publication_filter`, and `lab_contact`.
- Event-scoped custom dimensions: Publication ID (`publication_id`), Resource type (`resource_type`), Filter type (`filter_type`), Filter value (`filter_value`). Select a dimension in the Research engagement table to compare papers, resources, or taxonomy choices.
- The existing Search Console domain property `scienceofscience.org` is linked to web stream 15736506497. Its Search Console report collection is published.
- A September 7 launch annotation identifies the redesign, Analytics activation, and setup traffic.

Custom dimensions and standard reports can require 24–48 hours to populate. Realtime is the immediate collection check. A citation-copy event means the clipboard operation succeeded; a resource open is a click, and a contact event is an email-link click, not a completed inquiry. Free-text archive queries are not recorded.

## Monthly email

**SOS+CD Lab - Monthly activity summary** is scheduled in GA4 to send the Reports snapshot as a PDF to Daniel's existing Analytics account on the fourth of each month, beginning October 4, 2026. It uses the rolling **Last 28 days** report preset, not a full calendar month. The first report includes the September 7 setup day and an incomplete collection window.

The schedule was verified under **Admin → Property → Scheduled emails**: Monthly, PDF, one recipient, status Scheduled, active until October 4, 2027. Renew it before that expiration; GA4 schedules support up to 12 months. This email contains the dashboard's engagement, events, traffic sources, page views, and linked Search Console cards. It is separate from the public GitHub audit below. See [Google's scheduling instructions](https://support.google.com/analytics/answer/13722168?hl=en) to change recipients, frequency, or the active period.

## Monthly review

The **Monthly visibility review** GitHub Actions workflow runs on the eighth of each month and can be started manually. It checks every sitemapped HTML page on the live lab site for HTTP errors, canonical URLs, headings, descriptions, valid JSON-LD, Analytics tags, and access for Googlebot, OAI-SearchBot and ChatGPT-User. It also checks the publication export and the 2008 cutoff. Read the run summary and download the public audit artifact before its 90-day retention expires. GitHub may disable scheduled workflows in inactive public repositories; check the Actions tab if a run is missing.

Run the same check locally with `npm run audit:live`. Its default output is `tmp/live-seo/`. The workflow uses only public website data and read-only repository permissions; it does not access Google accounts or export private analytics automatically.

On each review, choose the latest complete Search Console date and use the same ending date in GA4. Compare the last **28 days** with the preceding 28, and the last **90 days** with the preceding 90. Use custom dates for exactly 90 days: Google's “3 months” preset is a calendar window. Mark any GA4 window crossing September 7 as incomplete. The first complete post-launch 28-day window excluding setup day is September 8–October 5.

Record:

1. Search Console web impressions, clicks, CTR and average position, then top pages and queries. Use **Page → URLs containing → `https://scienceofscience.org/`** for the current lab host. The unfiltered domain includes S4 and other subdomains. Keep any legacy `www` traffic separate.
2. **Performance → Generative AI on Search results**: impressions and cited pages, with the same page filter and dates. Keep this separate from normal web-search totals; don't add them together as independent audiences.
3. GA4 sessions and engagement by session source/medium; top landing pages and research page views.
4. Research resource opens by Publication ID and Resource type, citation copies by Publication ID, archive filters by Filter type/value, and contact clicks.
5. Changes shipped, indexing issues resolved, and one next action supported by the data. Low counts call for longer observation, not strong percentage-growth claims.

Store account exports and notes in `.impeccable/research/analytics/`, which is excluded from Git and the built website. The September 7 baseline is saved there locally as `2026-09-07-baseline.json`; its rounded figures are labeled as displayed, and its calendar-month window is not mislabeled as 90 days.

## AI referrals and answer quality

In Traffic acquisition, select **Session source / medium**, then filter the source using this regular expression when reviewing known AI referrals:

```
^(chatgpt\.com|chat\.openai\.com|perplexity\.ai|claude\.ai|gemini\.google\.com|copilot\.microsoft\.com)( / .*)?$
```

Match the source field without the optional medium suffix if using **Session source**. Referrals count identifiable visits, not mentions or citations. Apps can omit referrers, and Google AI visits are not reliably separable through this filter. Use Search Console's Google AI report for Google exposure. Bing Webmaster Tools is deferred at the user's request.

The prompt protocol in `.impeccable/review/ai-discovery-benchmark.json` is for a separate answer-quality check. Run each exact prompt in a fresh, web-enabled conversation; retain the date, product/model, answer, cited URLs, and criterion-level scores. Do not use this implementation conversation as an independent test, and do not call unrun cases a passed benchmark or a universal AI rank.

## Indexing follow-up

The current `https://scienceofscience.org/sitemap.xml` was submitted successfully on September 7. The only prior submission was an inaccessible 2017 HTTP sitemap. Google has discovered the new integrity hub through the current sitemap; its indexing request was accepted into the priority crawl queue. Submission is not a guarantee of indexing.

The old `/en/` homepage URL now redirects to `/`. Existing “crawled, not indexed” examples are largely feeds, legacy search URLs, S4 redirects and an older conference PDF; assess their purpose before trying to index them. The historical malformed structured-data report names `https://s4.scienceofscience.org/`, maintained in a separate repository. It is not evidence of invalid JSON-LD on the lab's current pages.

## Verified external identity links

- CU Boulder's [faculty profile](https://www.colorado.edu/cs/daniel-acuna) links directly to the lab and the correct Google Scholar profile.
- [acuna.io](https://acuna.io/) links to the lab and publications in its navigation and biography.
- Daniel's [ORCID 0000-0002-7765-1595](https://orcid.org/0000-0002-7765-1595) links to acuna.io and the correct Scholar profile. A direct lab link would shorten this path; no ORCID credentials were needed for the public audit.
- [PubMed Parser](https://github.com/titipata/pubmed_parser) already links to scienceofscience.org.
- The [MAMORX repository](https://github.com/sciosci/mamorx-review-system) homepage now links to its dedicated [lab overview](https://scienceofscience.org/publications/mamorx/), verified after deployment.

## Maintaining paper overviews

Add original summaries, findings, methods, limitations, source URLs, and review dates to `_data/publication_details.yml`. Optional `reuse` and `reuse_source_url` fields add practical guidance and an implementation/documentation link using the existing paper design. Check code and dataset licenses separately from article licenses. Update bibliographic facts in `_bibliography/references.bib`, then run `bundle exec ruby publications_generator.rb`; never hand-edit generated catalog or citation files.

Validation: `npm test`, a production Jekyll build, and `bundle exec ruby tests/seo_test.rb DESTINATION`. The production workflow runs these checks before deployment.

References: [Search Console integration](https://support.google.com/analytics/answer/10737381), [custom dimensions](https://support.google.com/analytics/answer/14239696), [Google AI performance reporting](https://developers.google.com/search/blog/2026/06/gen-ai-performance-reports), and [GitHub scheduled workflows](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#schedule).

## September 7 verification

The publication/search tests, five analytics behavior tests, and 12 production SEO tests (2,289 assertions) passed. GitHub build 34177613937 and Pages deployment 34177655099 succeeded. Public audit 34178256130 checked all 40 indexable HTML pages with zero issues. The AI referrals report was saved and added to the published Lab research collection.

GA4 page views and resource-open collection were confirmed during the initial activation. Live production interactions were also verified in the lab property's Realtime report: copying the SciIntBench citation produced `citation_copy` with `publication_id=meguimtsop2026sciintbench`, and selecting Research integrity in the publication archive produced `publication_filter` with `filter_type=topic` and `filter_value=integrity`. The archive displayed 18 of 70 works for that selection. Both events and their parameter values were inspected in Realtime. New standard reports may need processing time before showing data.
