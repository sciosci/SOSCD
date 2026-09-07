# Website redesign: baseline findings

## Scope and evidence

Inspected the running Jekyll site at localhost:4000, its layouts, all primary pages, the bibliography, news source, content generators, navigation, and deployment workflow. Existing content defines the Science of Science & Computational Discovery Lab at CU Boulder. Preserve names, research claims, publications, routes, historical content, affiliations, and application instructions.

## Information architecture

- The homepage repeats the long institutional name without explaining the research question in plain language. Its main actions lead to News and About rather than the research or recruitment paths.
- Three visually dominant generic illustrations duplicate navigation to publications, code, and one dataset. The illustrations explain little about this particular lab.
- All historical news is expanded on the homepage. Nine years of updates overwhelm recent work and the invitation to join.
- Research areas exist only as four bullets on Funding. Visitors cannot immediately connect methods, research questions, and published output.
- The dataset link is labeled plural but leads to one mentorship dataset. Make the destination explicit.
- Recruitment details are split across the homepage and Openings. Preserve the Fall 2027 opportunity and December 15, 2026 deadline from the existing homepage, and preserve the instruction to apply through the program instead of emailing the PI.

## Visual and interaction quality

- The dark generic blog theme gives decorative raster imagery disproportionate space. Header identity, headline, and large section images compete at the same visual weight.
- Accent colors are inconsistent: red openings link, cyan buttons, multicolor imagery, cyan news-year bars.
- People cards depend on inline CSS with round portraits and blank squares for missing photographs.
- Publication previews enlarge over adjacent text on hover, which undermines reading.
- Longform routes have inconsistent page structures and repeated inline style overrides.
- Publication headings create multiple H1s. The page has 56 bibliography records but only 54 visible by default because its filters omit unsupported record types.
- No native title/author search, usable empty state, or result count in the publication archive.

## Technical and maintenance findings

- Both index.html and _pages/index.md emit /index.html; Jekyll reports a destination conflict.
- news.yml is the news source of truth; news_generator.rb emits substantial inline presentational CSS. Redesign the generator as well as its output.
- _bibliography/references.bib is the publication source of truth; publications_generator.rb controls the generated region in _pages/publications.md. Preserve the generator workflow and markers.
- The current dependency set is already installed; Jekyll builds locally. No framework migration is required.
- The current Sass theme produces deprecation warnings. A focused modern stylesheet can remove the main site's dependency on the old theme's layout rules.
- Existing paper citation metadata must survive changes to the shared layout.

## Acceptance checks

Build successfully; one owner per route; primary and archival routes still render; publication count remains 56; filters/search work together and expose all record types; generator reruns are deterministic; mobile navigation, keyboard focus, reduced motion, heading order, image loading, and horizontal overflow verified in browser; desktop and mobile screenshots reviewed; final visual system recorded in DESIGN.md.
