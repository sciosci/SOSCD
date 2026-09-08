# Daniel and lab photography — September 7, 2026

The user requested newer photographs of Daniel and the lab image on About, with enlargement and a polished photographic treatment where sources were small. The site now uses two images sourced from [CU Boulder's Research Briefs 2026](https://www.colorado.edu/engineering/research-briefs-2026).

## Daniel portrait

- Original: `assets/images/lab/sources/daniel-cu-engineering-2026.png`, 228 × 228 pixels, preserved unchanged with its source URL and hash in the adjacent JSON file.
- Published in CU's 2026 engineering coverage; the source does not supply a capture date. Do not describe this as a photograph taken in 2026.
- The Codex CLI used its built-in image editor to produce one 1024 × 1024 candidate: `assets/images/lab/daniel-2026-enhanced.png`.
- [Exact image-tool prompt](daniel-portrait-enhancement-prompt.txt) is also embedded in the PNG and stored in every WebP sidecar. The prompt requests faithful facial geometry, glasses, expression, hair, age, clothing and pose, restrained editorial lighting, and extension of the original circular crop into a square frame.
- AI enhancement reconstructs fine detail and missing corners; it is not an untouched high-resolution original. The result was visually compared with the CU reference before use.
- Responsive WebP versions: `daniel-2026-160.webp`, `daniel-2026-320.webp`, `daniel-2026-640.webp`, and `daniel-2026.webp` (1024). These replace Daniel's portrait on the homepage and People page.

## Lab discussion

- Original: `assets/images/lab/sources/lab-meeting-2025-11-18.jpg`, 2539 × 1572 pixels, preserved unchanged with its source URL and hash in the adjacent JSON file.
- November 18, 2025 is supported by the original filename and the monitor's visible date. CU published the image in its 2026 engineering coverage.
- Responsive WebP versions: `group-2025-600.webp`, `group-2025-960.webp`, and `group-2025-1600.webp`.
- The full original frame is retained. Processing is limited to proportional resizing and WebP compression; the people, room, and scientific results on the screen are unaltered.
- About includes meaningful alt text, intrinsic dimensions, responsive sources, and a dated caption linking to CU Boulder for photo credit.

## Source selection

The CU Computer Science faculty directory, Information Science affiliate directory, August 2025 news article, and June 2025 Coursera feature all reuse the older green-shirt portrait. Their recent publication or crawl dates do not make the photograph new. Daniel's personal website has a different but undated 250px portrait. These were excluded in favor of the newer portrait in CU's 2026 coverage.

The engineering article [Engineering an AI-ready future](https://www.colorado.edu/engineering/ai-ready-future) also provides recent large lab photographs. The selected About photograph shows Daniel discussing results with lab members and directly replaces the older meeting scene. Other people's portrait assets and the original diamond logo remain outside this change.

## Verification

The production Jekyll build passed. About, People, and the homepage were checked at 1280px and 390px with 2× display density: all responsive images loaded, the full lab frame remained visible, portrait crops retained the face and headroom, and no horizontal overflow occurred. Captures are stored locally under `.impeccable/review/photo-refresh-*.png`.
