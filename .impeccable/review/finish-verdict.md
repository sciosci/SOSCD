## verdict

Evidence check passed: all 19 required paths were re-read and their refreshed captures are valid. This is the bounded F1–F4 verdict pass, not a new whole-site review.

- F1 — resolved: dataset-desktop.png and dataset-mobile.png visibly show the white “Get the dataset” label and arrow on violet. The corrected link selectors exclude button classes; the supplied browser state check confirms white foreground in normal, hover, and focus states.
- F2 — resolved: about-desktop.png and about-mobile.png now visibly separate the alumni link from “At home in Boulder,” with more space above the heading than below it. The 44 px wrapper gap addresses the first-child reset.
- F3 — resolved: people-desktop.png and people-mobile.png show “7 people” for the practica group, matching the seven unique people previously verified across eight historical role records. Other count labels retain the same people terminology.
- F4 — resolved: desktop.png and mobile.png show all four featured-paper titles before their topic/status metadata; the rows now read as supporting bibliographic information. The values remain present and no replacement eyebrow was introduced.

## remaining

Clear. No regressions introduced by this fix batch were visible. This ship verdict covers the scored fixes, not the whole surface.

disposition: ship
