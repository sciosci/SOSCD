# Lab logo restoration — September 7, 2026

The user supplied their original 91 × 101 px logo screenshot and clarified that **only the gray diamond and its blue/cyan left semicircles are the logo**. The purple rounded frame, white square and surrounding interface are excluded.

The authoritative production source is `assets/images/lab/logo.svg`: four flat vector paths, transparent outside the diamond, with the vertical color split and left-facing semicircles preserved. Colors were reconstructed from the supplied low-resolution reference (#d8d8d8, #eaeaea, #2d96bc, #2bb7d3); this is a faithful geometric reconstruction, not a claim of exact recovery of an unavailable original vector.

Header, footer and SVG favicon share this source. Chromium rendered transparent PNG exports at 2048, 192, 96, 180 and 32 pixels. The 2048 px export is `logo-restored.png`; the 180 and 32 px exports support Apple touch icons and older favicon clients. No surrounding frame, background, border radius, shadow or gradient is applied.

AI restoration was attempted through the user-requested Codex CLI using its built-in image editor. The model changed flat colors and geometry; the diamond-only attempt painted a checkerboard instead of producing an alpha channel. These outputs are not shipped. The deterministic SVG preserves the user's simple geometric identity more faithfully and scales without resolution loss.

The reference screenshot is retained as `logo-original-reference.png` for provenance only and is never displayed by the website. AI experiment outputs remain in `/tmp/soscd-logo-restoration/`, outside the site.
