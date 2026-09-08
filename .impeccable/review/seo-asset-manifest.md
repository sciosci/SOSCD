# SEO image asset manifest

## Scope and media inventory

This packet adds one social-sharing graphic, eight responsive portrait variants, and two publication-thumbnail variants. It preserves the established optical research bench identity and the exact user-required diamond mark. No AI generation, external imagery, photo retouching, or edits to original assets, templates, CSS, configuration, or data were used.

The social card is precise HTML/CSS/SVG geometry rendered with Chromium. Portraits are the lab's existing repository photographs. The publication thumbnail is an existing repository diagram. All new assets were visually inspected after creation.

## Source dimension verification

Dimensions were read directly from image headers with ImageMagick, independently of HTML attributes or Lighthouse's rendered dimensions.

| Existing asset | Actual dimensions |
| --- | --- |
| `assets/images/lab/daniel.webp` | 640 × 640 |
| `assets/images/lab/carolina.webp` | 640 × 640 |
| `assets/images/lab/pawin.webp` | 640 × 640 |
| `assets/images/lab/christopher.webp` | 640 × 640 |
| `assets/images/people/acuna-daniel.png` | 375 × 375 |
| `assets/images/people/carolina.png` | 1194 × 1194 |
| `assets/images/people/pawin_picture.png` | 800 × 800 (internally JPEG) |
| `assets/images/people/christoper.JPEG` | 1542 × 1542 |
| `assets/images/publications/paraphrase_preprint.png` | 448 × 507 |

The portrait variants were encoded from the original photographs, which preserve the same square composition as the existing 640px lab assets, avoiding a second lossy conversion. All crops and colors remain intact. SHA-256 checks confirmed that these original photos and the figure remained unchanged during conversion.

## Produced assets

Byte counts below include the PNG's embedded provenance, but exclude separate WebP provenance sidecars.

| Output | Source | Dimensions | Bytes |
| --- | --- | --- | ---: |
| `assets/images/lab/social-card.png` | Code-native brand composition; exact existing `logo.svg`; local Sora and Hanken Grotesk fonts | 1200x630 | 66,470 |
| `assets/images/lab/daniel-160.webp` | `assets/images/people/acuna-daniel.png` | 160x160 | 3,202 |
| `assets/images/lab/daniel-320.webp` | `assets/images/people/acuna-daniel.png` | 320x320 | 8,180 |
| `assets/images/lab/carolina-160.webp` | `assets/images/people/carolina.png` | 160x160 | 5,796 |
| `assets/images/lab/carolina-320.webp` | `assets/images/people/carolina.png` | 320x320 | 15,328 |
| `assets/images/lab/pawin-160.webp` | `assets/images/people/pawin_picture.png` | 160x160 | 9,252 |
| `assets/images/lab/pawin-320.webp` | `assets/images/people/pawin_picture.png` | 320x320 | 22,814 |
| `assets/images/lab/christopher-160.webp` | `assets/images/people/christoper.JPEG` | 160x160 | 3,748 |
| `assets/images/lab/christopher-320.webp` | `assets/images/people/christoper.JPEG` | 320x320 | 11,802 |
| `assets/images/publications/paraphrase_preprint-180.webp` | `assets/images/publications/paraphrase_preprint.png` | 180x204 | 5,264 |
| `assets/images/publications/paraphrase_preprint-360.webp` | `assets/images/publications/paraphrase_preprint.png` | 360x407 | 16,114 |

## Social card

- Recommended Open Graph and Twitter image: `/assets/images/lab/social-card.png`.
- MIME type: `image/png`; declared width: `1200`; declared height: `630`.
- Recommended image alt: `SOS+CD Lab — Science of Science & Computational Discovery Lab at CU Boulder.`
- Included text is the full lab name, SOS+CD Lab, CU Boulder, and Department of Computer Science.
- The graphic uses Sora and Hanken Grotesk loaded from the repository, with cool-white `#f5f3f8`, violet `#51358a`, and ink `#282234`. The diamond's original SVG paths and colors were used unchanged. Its neighboring rings are decorative geometry.
- Renderer waited for `document.fonts.ready`; final output was visually inspected at 1200 × 630. All text fits, the diamond is intact, and no external asset requests are required.
- Reproduction source for this run: `/tmp/soscd-social-card.html` (temporary, self-contained HTML with local font data and original logo SVG). The PNG embeds durable provenance through `embed-prompt.mjs`.

## Recommended srcsets

Use the existing 640px image as `src` where a large fallback is desired, then provide all three candidates. Set `sizes` from the actual rendered CSS slot; `160px` is an example for a compact portrait, not a universal people-page size.

```html
src="/assets/images/lab/daniel.webp"
srcset="/assets/images/lab/daniel-160.webp 160w,
        /assets/images/lab/daniel-320.webp 320w,
        /assets/images/lab/daniel.webp 640w"
sizes="160px"
width="640" height="640"
```

```html
src="/assets/images/lab/carolina.webp"
srcset="/assets/images/lab/carolina-160.webp 160w,
        /assets/images/lab/carolina-320.webp 320w,
        /assets/images/lab/carolina.webp 640w"
sizes="160px"
width="640" height="640"
```

```html
src="/assets/images/lab/pawin.webp"
srcset="/assets/images/lab/pawin-160.webp 160w,
        /assets/images/lab/pawin-320.webp 320w,
        /assets/images/lab/pawin.webp 640w"
sizes="160px"
width="640" height="640"
```

```html
src="/assets/images/lab/christopher.webp"
srcset="/assets/images/lab/christopher-160.webp 160w,
        /assets/images/lab/christopher-320.webp 320w,
        /assets/images/lab/christopher.webp 640w"
sizes="160px"
width="640" height="640"
```

For a publication thumbnail displayed at 180 CSS pixels or less:

```html
src="/assets/images/publications/paraphrase_preprint-180.webp"
srcset="/assets/images/publications/paraphrase_preprint-180.webp 180w,
        /assets/images/publications/paraphrase_preprint-360.webp 360w"
sizes="180px"
width="448" height="507"
```

The figure's source aspect ratio is 448:507. Resizing rounds output heights to 204 and 407 pixels. Preserve the source width/height ratio in layout and use `object-fit: contain` if a bounded thumbnail slot is required. Keep the full original PNG available for reading the diagram; its small text is necessarily abbreviated visually at thumbnail sizes.

Portrait alt text: `Daniel Acuña`, `Carolina Chávez-Ruelas`, `Pawin Taechoyotin`, and `Christopher Ebuka Ojukwu`. An empty alt is appropriate when the portrait is in the same link as the identical member name. Suggested publication alt: `Taxonomy of deep learning architectures for paraphrase identification.`

## Compression and provenance

Portraits: WebP quality 82, method 6, automatic orientation, proportional resizing, no crop. Publication figure: WebP quality 88, method 6, proportional resizing, no crop. Social card: native Chromium rendering, optimized 24-bit PNG.

Every produced raster was passed through `/Users/danielacuna/.agents/skills/impeccable/scripts/embed-prompt.mjs`. WebP files have adjacent `.webp.json` origin sidecars; the PNG stores its provenance in a `tEXt` chunk. Preserve the sidecars with their image files.

Verification on the eleven produced rasters: `SCAN: 11 rasters, 0 missing` (exit 0). Source and output images were visually inspected, including a contact sheet of all ten responsive variants. No generated AI pixels or substitute lab photographs were introduced.
