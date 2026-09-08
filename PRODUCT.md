# Science of Science & Computational Discovery Lab

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

Working assumption, pending the user's answers: prospective research students and collaborators are the primary audience. Researchers accessing publications, code, datasets, and lab news are an equally important secondary audience.

## Product Purpose

Present the research, people, publications, projects, and opportunities of the Science of Science & Computational Discovery Lab (SOS+CD), led by Daniel Acuña in the Department of Computer Science at the University of Colorado Boulder.

## Positioning

The lab studies science itself and develops computational methods to mine knowledge from scientific publications, citations, and images. Its existing research spans scientific peer review, computational research integrity, recommendation systems for science, and bias in artificial intelligence. Methods include deep learning, natural language processing, graph analytics, image processing, and causal inference.

## Operating Context

The website is a Jekyll site. Publications originate in _bibliography/references.bib and the generated area of _pages/publications.md. News originates in news.yml and is rendered by news_generator.rb. People, funding, openings, and about content are maintained as Markdown pages. GitHub Actions builds the site after running both generators.

## Capabilities and Constraints

- The user requests a complete visual revamp, deep analysis using Impeccable, a running local server, and browser verification.
- If new AI imagery is needed, the user requests generation through the codex CLI.
- Preserve existing factual content, all bibliographic records and associated paper/code/data links, people and alumni, funding entries, contact address, historical pages, and citation metadata.
- Preserve existing route destinations and the content generation workflow.
- Publication discovery uses explicit, overlapping topics and tags for every record. Search and the homepage explorer must share those assignments.
- The user requests a Support page routed through CU giving. Until a lab-specific fund and URL are confirmed, show contact options without a payment button or a generic department donation link.
- The main page and navigation say “Join Us” and cover joining the lab generally. Ph.D. applications are a section within that page, alongside other research opportunities. Ph.D. content provides general application guidance, not an advertisement for a fixed number of positions or a specific admissions cycle. Use objective language, link current requirements and deadlines to the CU Boulder Computer Science Ph.D. program, identify Daniel Acuña as the prospective adviser, and preserve the instruction not to email the PI about individual Ph.D. applications. Do not describe funding as guaranteed or fully funded. Keep other research opportunities factual and separate.
- No framework migration or deployment is requested.

## Brand Commitments

Preserve the lab name and its CU Boulder affiliation. The user explicitly requests their original lab icon: a gray diamond with blue and cyan left semicircles, with transparent space outside the diamond. Their uploaded reference and subsequent clarification are authoritative: the surrounding purple frame is not part of the logo. Replace the invented orbital brand mark with a faithful restoration of this original; preserve its shape, color, and asymmetry. The modern page design remains, but the lab icon is no longer an open identity decision.

## Evidence on Hand

70 bibliography records from 2008 onward (14 verified additions from the Google Scholar comparison); news from 2018 through 2026; existing member photographs; project and funding descriptions; a mentorship dataset; a ScioSci GitHub organization; detailed paper landing pages. Use this material as evidence. Do not invent publications, collaborators, outcomes, statistics, testimonials, or photographs of the actual lab.

## Product Principles

- Explain the scientific questions before asking visitors to navigate the archive.
- Connect research to the people and published work that substantiate it.
- Keep the long archive accessible without overwhelming first-time visitors.
- Keep content maintainable through the existing source files and generators.

## Open Decisions

Audience priority remains provisional. The original lab icon is now required by the user. A confirmed CU gift fund name and direct donation URL remain outstanding.
