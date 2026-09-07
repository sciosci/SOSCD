# Final updates review — September 7, 2026

Scope: publication taxonomy and Scholar reconciliation, funding language, CU support page, explorer previews, and the user's diamond logo correction.

Verdict: ready for local review. Build and publication regression checks passed. The local Jekyll server is running at http://127.0.0.1:4000/. No deployment or external messages were made.

The logo uses a transparent native SVG in the header, footer and favicon. Desktop and phone captures confirm no rounded frame or border. The exported 2048 px and 32 px PNGs have alpha channels. The high-resolution raster is a rendering of the geometric source, not an AI approximation.

Publication evidence, the full 79-row Scholar disposition ledger and source limitations are recorded in `scholar-reconciliation.md`. Fourteen works were added, bringing the total to 70. Dates begin in 2008. One undated OpenReview version could not be confirmed as a separate publication and was left out; its related journal article is already present. The archived commentary download could not be independently opened because its server returned HTTP 429.

The final publication browser pass covered 36 topic/tag routes, all 70 preview bindings, actual preprint dates, alternate-title and full-author search, author disclosure, no-JavaScript readability, and desktop/phone layout. No local page JavaScript errors or horizontal overflow were observed. The initial pass also checked keyboard/focus behavior, hover persistence and Escape dismissal, empty states, URL reload/back/reset, and all support-page widths from 320 to 1440 px. The detailed evidence is in `publication-taxonomy-review.md` and `final-publication-browser-checks.json`.

The support page currently routes inquiries to the lab and CU Advancement. A direct payment action is intentionally inactive until CU supplies the lab's confirmed fund name and direct giving URL. The draft Advancement inquiry and activation procedure are in `../decisions/giving-setup.md`. No email was sent.
