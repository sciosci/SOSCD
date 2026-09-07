# Browser and build verification

## Scope

Complete visual replacement of the Jekyll lab website. The original user request authorizes the redesign, local server, deep analysis with Impeccable, and codex CLI if new AI section images are needed. Questions about audience, build preference, and identity were offered asynchronously; no replies have arrived. PRODUCT.md explicitly marks the audience and identity assumptions. The implementation is code-led; there is no approved raster comp or QUALITY BAR image for this grounded direction. No AI images were necessary: the hero is an exact SVG publication index, with real existing photographs elsewhere.

## Build and content

- `npm run build` successfully generates news, bibliography-derived data, and the Jekyll static site.
- The duplicate homepage owner was removed; _pages/index.md owns `/`.
- All 56 bibliography records render, across 20 year groups. The bibliography itself is unchanged.
- Paper landing pages retain scholarly metadata and body content. The existing `/s4/` redirect is preserved.
- News descriptions are preserved; one formerly relative mentorship link was corrected when introducing `/news/`.
- Current people and all alumni records are preserved. Alumni details use native expandable groups.
- All ten funding entries are retained. Admissions dates and instructions derive from existing site content.

## Browser behavior

At 1440 and 390 px: home, publications, people, funding, about, openings, news, mentorship, undergrads, workshops, deadlines, and both paper landing pages returned HTTP 200 with no horizontal overflow. `/s4/` retains its intentional redirect. Each non-redirect page has one H1.

- Publications default: 56 visible works.
- With code: 7 results, all carrying a code link.
- Search `sciintbench`: one result; query URL survives reload.
- Unmatched search: zero results and visible empty state.
- Clear search & filters: all 56 restored and search input focused.
- Year 2026: three results in one year group.
- Integrity lens: three matching points highlighted; related paper link changes to SciIntBench.
- Mobile navigation opens, reports aria-expanded, closes on Escape, and returns focus to the menu button.

## Visual evidence

Screenshots in this directory show the finished site with local fonts loaded, all images decoded, and reduced motion enabled. Home is captured at desktop 1440, mobile 390, and actual initial browser width 1280. Supporting pages have desktop and mobile captures. Publications and news captures are first viewport only; other captures are full pages. No broken images or overflow were found in the capture batch.

## Contrast and detector scope

A browser-computed foreground/background contrast pass checked visible text on home, publications, people, funding, about, and openings: no failures at 4.5:1 body / 3:1 large text. This is a targeted check, not a full accessibility certification. The dataset page was checked during the finish correction: the button label and SVG arrow remain white on violet in normal, hover, and focus states. Both desktop and mobile captures confirm the repair.

The Impeccable detector ran once in degraded regex mode because optional parser modules were unavailable. It cannot certify computed contrast in this environment. It reported one layout-transition warning in lab.css line 77, corresponding to `stroke-width` on SVG points. This animates SVG paint, not CSS layout width; retain as an explained false positive. The exact detector output is in detector.json.

## Asset provenance

Five optimized WebP photographs have source provenance sidecars; the asset producer's scan passed 5/5. Referenced existing paper illustrations have origin sidecars, with their original pixels preserved. Font files and OFL licenses are self-hosted under assets/fonts.

## Finish review and final checks

The independent general reviewer inspected all 19 required captures plus sampled source and returned four bounded fixes. All four are resolved in finish-verdict.md: dataset action contrast, About section separation, the accurate seven-person practica count across eight historical role records, and title-first metadata on all four selected papers. The follow-up ship verdict covers these fixes and evidence validity; it is not a new whole-surface audit or accessibility certification.

- Regenerated all 19 captures after the fixes; each returned HTTP 200, with no broken images or horizontal overflow.
- Computed About grouping gap: 44.09 px above the heading and 25 px below, at 1440 and 390 px.
- Final static scan of all 14 generated HTML pages: no missing internal links, broken anchors, duplicate IDs, or missing local images. See link-check.json.
- `npm run build` passes with the final implementation, and `git diff --check` passes.
- Bibliography source remains byte-identical; all 56 publication records, 47 alumni role records, and ten funding records are retained.
- The dev server was restarted with the finalized configuration at http://127.0.0.1:4000.
- DESIGN.md and .impeccable/design.json are produced by the documenter from the final source; these describe the implemented design and do not claim a separately approved visual comp.
