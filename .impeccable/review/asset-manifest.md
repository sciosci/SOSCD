# Lab photography asset manifest

Prepared for the optical research bench direction. Every source was viewed before conversion. All five assets are existing repository photographs; no stock or AI imagery was used, and no source photo was changed.

## Media inventory

- Four real member portraits for the people page and homepage people section.
- One documentary lab discussion photograph for supporting about content. The image shows participants gathered around a research presentation in an office/meeting room. Its source does not establish the location, date, or current membership, so avoid adding those claims in captions.
- The main hero is semantic, interactive SVG research-theme geometry built in code. This packet produces no hero substitute or approved raster composition.
- Photography retains its natural color and original crop. The site should supply the visual direction through its layout, typography, controls, and surrounding surfaces.

## Produced files

| Source | Source dimensions | Source bytes | Output | Output dimensions | Output bytes | Recommended alt text |
| --- | --- | ---: | --- | --- | ---: | --- |
| `assets/images/people/acuna-daniel.png` | 375x375 | 195,898 | `assets/images/lab/daniel.webp` | 640x640 | 19,584 | Daniel Acuña |
| `assets/images/people/carolina.png` | 1194x1194 | 2,187,045 | `assets/images/lab/carolina.webp` | 640x640 | 42,172 | Carolina Chávez-Ruelas |
| `assets/images/people/pawin_picture.png` | 800x800 | 135,577 | `assets/images/lab/pawin.webp` | 640x640 | 50,410 | Pawin Taechoyotin |
| `assets/images/people/christoper.JPEG` | 1542x1542 | 240,551 | `assets/images/lab/christopher.webp` | 640x640 | 46,400 | Christopher Ebuka Ojukwu |
| `assets/images/daniel-acuna-research-group-medium.png` | 600x472 | 469,446 | `assets/images/lab/group.webp` | 600x472 | 37,836 | Lab members discussing research around a presentation screen. |

Original image payload: 3,228,517 bytes. Optimized image payload: 196,402 bytes, a reduction of 93.9% (provenance sidecars excluded).

## Conversion and usage notes

- ImageMagick conversion: automatic orientation, resize preserving aspect ratio, strip original metadata, WebP quality 82, compression method 6. No crop, retouching, compositing, or AI generation.
- Portraits are 640 × 640. Daniel's supplied PNG is only 375 × 375 and was upsampled to fulfill the requested output dimensions; this does not add photographic detail. Prefer a rendered portrait size of 320 CSS pixels or less. The existing alternate WebP has a different 375 × 563 composition, so it was not substituted for the supplied square source.
- The group image remains at 600 × 472. The maximum permitted edge was 1400 pixels; enlarging this source would add no detail. Use it as supporting content at its native aspect ratio, not a full-bleed hero.
- `pawin_picture.png` is internally JPEG-encoded despite its source filename. ImageMagick decoded its actual format correctly.
- Portrait alt text can be empty when the same member name is already present in the same link and the image adds no additional meaning. Otherwise, use the member name from the table. The group image should use the descriptive alt text in the table.
- Include width and height attributes to reserve each image's aspect ratio. Lazy-load only images below the initial viewport.

## Provenance verification

Each output was passed to `embed-prompt.mjs` with: `Existing repository photograph: <source>; resized and converted to WebP; no AI generation.`

For WebP, the provenance tool writes a sibling `<image>.json` file. Preserve those five sidecars beside the source assets. Source SHA-256 hashes were compared before and after conversion; every source remained unchanged.

Verification command: `node /Users/danielacuna/.agents/skills/impeccable/scripts/embed-prompt.mjs --scan assets/images/lab`.

Result: `SCAN: 5 rasters, 0 missing` (exit 0). All five optimized files were visually inspected after conversion; subjects, composition, orientation, and natural color are preserved.
