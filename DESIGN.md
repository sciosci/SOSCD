---
name: "SOS+CD Lab"
description: "An optical research bench for reading and exploring the lab's scientific work."
colors:
  surface: "#f5f3f8"
  paper: "#fff"
  ink: "#282234"
  muted: "#686173"
  purple: "#51358a"
  purple-dark: "#38245f"
  purple-pale: "#e9e2f2"
  acid: "#e4f694"
  line: "#d9d3e1"
typography:
  display:
    fontFamily: "Sora, sans-serif"
    fontSize: "clamp(48px, 6.3vw, 84px)"
    fontWeight: 500
    lineHeight: 1.15
    letterSpacing: "-.035em"
  headline:
    fontFamily: "Sora, sans-serif"
    fontSize: "clamp(32px, 3.4vw, 46px)"
    fontWeight: 500
    lineHeight: 1.15
    letterSpacing: "-.035em"
  title:
    fontFamily: "Sora, sans-serif"
    fontSize: "25px"
    fontWeight: 500
    lineHeight: 1.15
    letterSpacing: "-.035em"
  body:
    fontFamily: "Hanken Grotesk, sans-serif"
    fontSize: "18px"
    fontWeight: 400
    lineHeight: 1.55
  label:
    fontFamily: "Hanken Grotesk, sans-serif"
    fontSize: "13px"
    fontWeight: 600
rounded:
  compact: "4px"
  filter: "6px"
  control: "8px"
  portrait: "10px"
  panel: "12px"
  radius: "14px"
  circular: "50%"
spacing:
  "8": "8px"
  "12": "12px"
  "16": "16px"
  "20": "20px"
  "24": "24px"
  "30": "30px"
  "35": "35px"
  "40": "40px"
  "55": "55px"
  "70": "70px"
  "100": "100px"
components:
  button-primary:
    backgroundColor: "{colors.purple}"
    textColor: "{colors.paper}"
    rounded: "{rounded.control}"
    padding: "15px 22px"
  button-primary-hover:
    backgroundColor: "{colors.purple-dark}"
  button-light:
    backgroundColor: "{colors.acid}"
    textColor: "{colors.purple-dark}"
    rounded: "{rounded.control}"
    padding: "15px 22px"
  text-link:
    textColor: "{colors.purple}"
  search-input:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.ink}"
    rounded: "{rounded.control}"
    padding: "14px 16px 14px 49px"
    height: "55px"
  archive-filter:
    backgroundColor: "transparent"
    textColor: "{colors.ink}"
    rounded: "{rounded.filter}"
    padding: "9px 14px"
  archive-filter-selected:
    backgroundColor: "{colors.purple}"
    textColor: "{colors.paper}"
  lens-filter-selected:
    backgroundColor: "{colors.acid}"
    textColor: "{colors.purple-dark}"
    rounded: "{rounded.filter}"
    padding: "8px 7px"
  nav-join:
    backgroundColor: "transparent"
    textColor: "{colors.purple}"
    rounded: "{rounded.control}"
    padding: "11px 15px"
  selected-paper:
    padding: "30px 0 27px"
  reading-panel:
    backgroundColor: "{colors.purple-pale}"
    rounded: "{rounded.panel}"
    padding: "35px"
---

# Design System: SOS+CD Lab

## Overview

**Creative North Star: "Optical research bench"**

The implemented system sets geometric scientific forms against a cool, light reading surface. Violet identifies interactive elements and contains the publication lens; chartreuse marks selections and invitations. Open rows, clear type, and generous separation let dense research records coexist with short introductory passages.

This is a scan of the completed implementation in `assets/css/lab.css`, `assets/js/lab.js`, the lab layout, and its components. The north star describes the code-led direction recorded in the layout; it is not a claim that the user approved this palette or a particular composition. Audience priority remains provisional. The user requires the original diamond logo: a gray diamond with blue and cyan left semicircles and transparent surroundings. It is reconstructed as an SVG and shared by the header, footer, and icons. AI restoration was explored through the Codex CLI, but its altered colors and painted transparency were unsuitable; no AI-generated raster is shipped. Existing photographs and publication-linked SVG geometry provide the other visual evidence.

**Key Characteristics:**

- Cool reading surfaces, violet structure, and chartreuse selection.
- Sora headings paired with Hanken Grotesk reading and control text.
- Flat, ruled records with selective rounded panels.
- Real portraits, precise SVG geometry, and addressable publications.
- Native links and disclosure elements, with optional filtering and restrained motion.

## Colors

The palette combines a violet primary family, a chartreuse secondary accent, and lightly violet neutrals. The frontmatter preserves the source custom-property values.

### Primary

- **Instrument violet** (`purple`): primary actions, links, identity details, current navigation, and large research or recruitment fields.
- **Deep violet** (`purple-dark`): primary-button hover and text on chartreuse.
- **Pale violet** (`purple-pale`): reading panels, archive notes, code backgrounds, and quiet circular paper links.

### Secondary

- **Chartreuse selection** (`acid`): selected lens filters and publication points, light buttons, the opportunity strip, text selection, and focus outlines on violet fields.

### Neutral

- **Cool reading surface** (`surface`): the page and header ground.
- **White paper** (`paper`): selected-publication section and form fields; also light text on violet.
- **Violet ink** (`ink`): primary reading text.
- **Muted violet gray** (`muted`): supporting paragraphs, authors, dates, labels, and affiliation text.
- **Soft rule** (`line`): record separators, form borders, and structural dividers.

**The Selection Contrast Rule.** Selected archive filters use violet with white text; selected filters inside the violet lens use chartreuse with deep-violet text. Preserve the explicit pressed state as well as the color change.

## Typography

**Display Font:** Sora, with a sans-serif fallback.

**Body Font:** Hanken Grotesk, with a sans-serif fallback. Both families are locally hosted variable fonts with the implemented weight range (400–700).

**Character:** Medium-weight geometric headings supply the identity. The reading face handles paragraphs, navigation, controls, and metadata with a quieter texture. There is no mathematical type ratio: the source combines fluid page headings with component-specific fixed sizes.

### Hierarchy

- **Display:** the frontmatter records the shared heading baseline. The homepage and publication heading deliberately override it; do not copy their page-specific sizes into every new heading.
- **Headline:** fluid section headings become fixed, smaller headings at narrower widths and in long-form prose.
- **Title:** medium-weight titles identify research questions. Publication and member titles use smaller sizes and more open line heights suited to longer names and titles.
- **Body:** the frontmatter records the default reading role. Long-form text is limited to approximately (73ch); supporting copy uses smaller sizes and the muted text color. Mobile prose uses (17px).
- **Label:** explicit field labels use the compact semibold role. Other metadata varies by context, usually (12–14px). Dates, publication years, and counts use tabular numerals.

**The Reading Measure Rule.** Constrain prose and supporting copy independently of the outer page container; use open line height for bibliographic titles and author lists.

## Layout

The main container is centered with a maximum width (1280px) and desktop side space (56px). At widths up to (1150px), the general side space becomes (40px); at (680px), it becomes (20px); at (360px), it becomes (16px). The header has its own wider desktop container, capped at (1360px), and is in document flow.

Shared sections use generous vertical space, stepping from (100px) to (70px) below (960px), then (57px) below (680px). The spacing entries in the frontmatter are repeated source values, not a newly imposed scale. Individual components retain their observed padding and gaps.

Desktop content mixes asymmetric introductions, paired publication columns, and ruled records with a narrow date or year column. The people grid changes from four to two columns below (960px). Below (680px), major paired layouts and year/record layouts stack, while the people grid retains two columns and the compact portrait preview retains three. Search and year controls stack at the same breakpoint. The research lens moves below its introduction and scales within the available width.

The optional contents navigation has a (200px) desktop column and a sticky inner navigation; it becomes a static, wrapping list below (960px). The main navigation switches to an explicit menu at that breakpoint when JavaScript is available. Without JavaScript, those links remain visible in flow. Long tables and code blocks scroll within their content area.

Print styles remove navigation and interactive tools, simplify the page to black on white, and restore filtered publication records to the printed archive.

## Elevation & Depth

The implemented system uses no box shadows. Depth comes from alternating the cool ground and white section, violet fields, pale-violet panels, and thin divider lines. Interactive emphasis changes color, outlines, underlining, or SVG position rather than raising a container.

**The Flat Records Rule.** Keep publication, news, funding, and research records on their reading plane, separated by rules and space. Reserve filled rounded fields for the panel patterns that already use them.

## Shapes

Controls use modest rounded corners; compact filters are slightly tighter. Portraits, pale reading panels, and large violet fields use progressively softer corners, as recorded in the frontmatter. Circular actions accompany publication links, while fine circular geometry defines the research lens, while the lab identity remains the user’s original gray and blue diamond. These are separate uses of shape, not a requirement to make every container circular or rounded.

Most separators and control borders are (1px). SVG arrows and scientific symbols use explicit strokes, while photographic crops remain rectangular with rounded corners. Real member photographs use `object-fit: cover`; publication figures use `object-fit: contain` so the evidence is not cropped.

## Components

### Buttons

Clear text and a small SVG arrow form the primary action pattern. Primary buttons use violet and white; light buttons use chartreuse and deep violet. The shared minimum height is (54px), with semibold reading text (16px), the control radius, and the frontmatter padding. Color transitions take (0.2s). Hover darkens the primary fill or lightens the chartreuse fill and moves the arrow (4px) over (0.22s) using the source easing. Disabled native buttons reduce opacity to (0.45) and use a not-allowed cursor.

### Text links

Action links pair violet semibold text with a stroked arrow. Hover adds an underline and the same arrow translation. Inline reading links remain underlined; their hover increases underline thickness. Use inline SVG arrows, not glyph substitutes.

### Chips

These are filter buttons rather than decorative tags. Archive filters have transparent resting fills, a soft border, and a pale-violet hover; the selected filter becomes violet with white text. Lens filters use light text and a visible border on the violet field; the selected filter uses chartreuse. Both expose `aria-pressed`. The lens selection dims other points and changes the count, caption, and link to the complete topic archive. The same explicit topic assignments drive the lens and publication filters.

### Cards / Containers

Selected papers are open, top-ruled records with a title, metadata, author line, venue, and circular link. They form two columns on desktop and one on phones. The bibliography uses year groups and ruled list items rather than isolated cards. Pale reading panels use the panel radius and shared padding; recruitment fields use the large radius and violet ground. None of these patterns adds a shadow.

### Inputs / Fields

The search field is white with a soft border, the control radius, a visible text label, and a leading SVG search icon. It has a fixed height (55px); the companion native year selector has the same minimum height. Search placeholders use the muted text color and the caret uses violet. Focus is an outline (3px) offset (5px), shared with links, buttons, selectors, and summaries. The outline becomes chartreuse on violet containers. No custom error-state system is implemented.

Search, topic, tag, year, and format/resource filters combine, update a polite result count, and preserve their values in the URL. Topics can overlap, and linked labels beneath each publication open that topic or tag. Counts on the native selectors reflect the other active filters. An empty state offers a reset that returns focus to search. Tools are revealed only after JavaScript initializes; the full bibliography remains readable without it.

### Navigation

The header combines the SOS+CD identity with compact navigation. Current ordinary links use violet text and a short bottom rule; the openings link is an outlined rounded action that fills violet on hover or when current. Below (960px), the JavaScript menu opens a wrapping panel under the header. It closes on Escape, outside interaction, link selection, or return to desktop width; Escape returns focus to the menu button. A skip link appears on keyboard focus.

### Research lens

A violet panel contains precise SVG rings and real publication links. Radius orders actual publication time for every work; larger nodes distinguish preprints; topic groups support exploration and do not represent a citation network. All five controls (All work, Integrity, Discovery, Ecosystem, Methods) use the same overlapping taxonomy as the archive. Nodes stay addressable as native links. Hover and keyboard focus reveal a title-first white preview with authors, year, venue, and topics. It remains open while hovered, is dismissible with Escape, and replaces native SVG title popups. On phones, the preview flows below the map to retain the full text without an internal scroll area. Hover or focus turns a node white and strengthens its chartreuse stroke. The initial point field settles from a small rotation over (1.4s); state changes use short fades and the shared easing (`cubic-bezier(.16,1,.3,1)`). Reduced-motion preference removes animations, transitions, and smooth scrolling while preserving the full static composition.

### People and disclosures

Portraits show actual people, with name initials where a photograph is unavailable. The preview uses slightly subdued saturation that returns on hover. People and alumni remain readable as text; native details/summary elements reveal alumni groups and paper abstracts. Disclosure arrows are CSS strokes, with the open state changing their orientation.

## Do's and Don'ts

### Do:

- **Do** use the source palette and the two locally hosted font families across new surfaces.
- **Do** keep explicit labels, visible focus, current navigation, and pressed filter states alongside their visual treatments.
- **Do** use rules and whitespace to organize reading records, and constrain prose within wide layouts.
- **Do** preserve native links, readable content without JavaScript, and a complete reduced-motion presentation.
- **Do** use real photographs and publication evidence, with honest text fallbacks when an asset is missing.

### Don't:

- **Don't** add shadows to the existing flat record and panel patterns.
- **Don't** treat the lens as evidence of citation relationships or invent research links to fill it.
- **Don't** promote homepage-specific composition, tiny decorative labels, or one-off color variations into reusable system requirements.
- **Don't** present the implemented direction or unresolved identity assumptions as user-approved brand policy.

Publication archive titles use normal text wrapping (`.bib-title { text-wrap: wrap; }`) so each line uses the available column width. The global balanced-heading rule does not apply to bibliography titles.
