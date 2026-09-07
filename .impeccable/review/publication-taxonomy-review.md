# Publication discovery review — September 7, 2026

## Findings and scope

Reviewed all 56 original bibliography records and assigned the 14 verified Scholar additions, their titles, venues, formats, links, and research context. Consulted primary-source abstracts and descriptions for category boundaries, including figure integrity, citation practices, resource longevity, interdisciplinary analysis, retrieval, recommendation, and automated review. This is an editorial navigation taxonomy, not a claim to have read every full text or to supply an externally validated bibliometric classification.

Previously, `q=integrity` returned only two records because it searched visible text. The homepage used title regexes and forced every paper into one of three buckets, defaulting unrelated cognition and methods work to the research ecosystem. `review` also matched the journal name Psychonomic Bulletin & Review.

Every bibliography key now has reviewed topics and tags in `_data/publication_taxonomy.yml`. Topics overlap. More specific tags distinguish peer review from the combined discovery topic, and image forensics from graphical integrity. Search understands labels and aliases; exact topic/tag queries use membership instead of incidental mentions in venues. Full-title phrase search and ordinary author/title terms remain supported.

## Category boundaries

- **Research integrity — 18:** scientific reliability and responsible practice, including figure/journal quality, omitted citations, review bias, reproducibility, and metadata quality. Quality problems do not imply misconduct. Figure accessibility and reference missingness are included under this broader reliability definition, with notes in the taxonomy.
- **Peer review & discovery — 24:** peer-review research and computational methods for scientific retrieval, recommendation, extraction, and evaluation. General paraphrase and recommender explanations are included as supporting methods and also assigned to Cognition & methods.
- **Science of science — 33:** careers, mentorship, funding, diversity, collaboration, and scholarly infrastructure.
- **Cognition & methods — 25:** historical and foundational computational/cognitive work. It is an explicit category, not an automatic fallback.
- **Peer review tag — 5:** REM-CTX, REMOR, MAMORX, author-suggested reviewers, and professional-network judgments. The paraphrase survey and unrelated neuroscience paper are excluded.

The totals overlap; the archive now has 70 records. See [Scholar reconciliation](scholar-reconciliation.md) for the 14 additions, existing-record corrections, deduplication and source limitations. Explicit format assignments distinguish 33 journal articles, 21 conference/workshop records, 13 preprints/working papers, one web article, one chapter and one thesis. All years are actual dates from 2008 onward.

## Primary-source checks informing the boundaries

- [Graphical integrity](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1009650): detection of misleading graphical presentation belongs to integrity even without a misconduct finding.
- [Figure accessibility, readability, and explainability](https://link.springer.com/article/10.1140/epjds/s13688-023-00380-y): scientific-communication quality, not a claim of manipulation.
- [Citation worthiness](https://arxiv.org/abs/2405.12206): omitted citations and pre-submission checks connect the text-mining method to integrity.
- [Resource longevity](https://www.nature.com/articles/s41599-025-04716-z): maintaining linked resources supports reproducibility.
- [Author-suggested reviewers](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0273994): review evaluation overlaps integrity and the scientific ecosystem.
- [MISTI](https://aclanthology.org/2024.sdp-1.15/): scientific figure/caption retrieval, not itself peer-review generation.
- [Interdisciplinary engagement](https://aclanthology.org/2024.nlpcss-1.11/): automated analysis of citation context links methods and science of science.
- [RecSOI](https://link.springer.com/article/10.1186/s13326-024-00304-3): recommending research directions belongs to discovery.
- [Comparative recommendation explanations](https://ceur-ws.org/Vol-3815/paper1.pdf): general recommender methods, not specifically peer review.
- [MAMORX](https://neurips.cc/virtual/2024/105900), [REMOR](https://arxiv.org/abs/2505.11718), and [REM-CTX](https://arxiv.org/abs/2604.00248): automated peer-review generation.
- [SciIntBench](https://arxiv.org/abs/2605.29468): evaluation of responsible conduct in AI-assisted scientific work.

## Complete assignment ledger

| Record | Topics | Specific tags | Classification note |
| --- | --- | --- | --- |
| Bayesian modeling of human sequential decision-making on the multi-armed bandit problem (`acuna2008bayesian`) | Cognition & methods | Decision-making, Reinforcement learning | Based on the bibliography title and research context. |
| Structure learning in human sequential decision-making (`acuna2008structure`) | Cognition & methods | Decision-making, Reinforcement learning | Based on the bibliography title and research context. |
| Improving bayesian reinforcement learning using transition abstraction (`acuna2009improving`) | Cognition & methods | Reinforcement learning, Decision-making | Based on the bibliography title and research context. Format override: inproceedings. |
| People efficiently explore the solution space of the computationally intractable traveling salesman problem to find near-optimal tours (`acuna2010people`) | Cognition & methods | Decision-making | Based on the bibliography title and research context. |
| Structure learning in human sequential decision-making (`acuna2010structure`) | Cognition & methods | Decision-making, Reinforcement learning | Based on the bibliography title and research context. |
| Rational Bayesian Analysis of Sequential Decision-Making Under Uncertainty In Humans and Machines (`acuna2011rational`) | Cognition & methods | Decision-making, Reinforcement learning | Based on the bibliography title and research context. |
| Toward perceiving robots as humans: Three handshake models face the turing-like handshake test (`avraham2012toward`) | Cognition & methods | Human–computer interaction, Perception & psychophysics | Based on the bibliography title and research context. |
| Predicting scientific success (`acuna2012predicting`) | Science of science | Scientific careers & recognition, Citation analysis | Based on the bibliography title and research context. |
| The future h-index is an excellent way to predict scientistsˈ future impact (`acuna2013future`) | Science of science | Scientific careers & recognition, Citation analysis | Based on the bibliography title and research context. |
| Multifaceted aspects of chunking enable robust algorithms (`acuna2014multifaceted`) | Cognition & methods | Neuroscience & motor learning, Decision-making | Based on the bibliography title and research context. |
| Using psychophysics to ask if the brain samples or maximizes (`acuna2015using`) | Cognition & methods | Perception & psychophysics, Decision-making | Based on the bibliography title and research context. |
| Chunking as the result of an efficiency computation trade-off (`ramkumar2016chunking`) | Cognition & methods | Neuroscience & motor learning, Decision-making | Based on the bibliography title and research context. |
| Adaptive neuron-to-EMG decoder training for FES neuroprostheses (`ethier2016adaptive`) | Cognition & methods | Neuroscience & motor learning, Statistical methods & software | Based on the bibliography title and research context. |
| Science Concierge: A fast content-based recommendation system for scientific publications (`achakulvisut2016science`) | Peer review & discovery | Research recommendation, Recommender systems, Text mining & NLP | Based on the bibliography title and research context. |
| Show Me Your App Usage and I Will Tell Who Your Close Friends Are: Predicting User's Context from Simple Cellphone Activity (`shema2017show`) | Cognition & methods | Human–computer interaction | Based on the bibliography title and research context. |
| Bioscience-scale automated detection of figure element reuse (`acuna2018bioscience`) | Research integrity | Figure integrity, Image reuse & forensics | Based on the bibliography title and research context. Format override: preprint. |
| The sociology of scientific validity: How professional networks shape judgement in peer review (`teplitskiy2018sociology`) | Research integrity, Peer review & discovery, Science of science | Peer review, Review bias, Teams & collaboration | Based on the bibliography title and research context. |
| Intellectual synthesis in mentorship determines success in academic careers (`lienard2018intellectual`) | Science of science | Mentorship, Scientific careers & recognition, Interdisciplinarity | Based on the bibliography title and research context. |
| Limiting motor skill knowledge via incidental training protects against choking under pressure (`lee2019limiting`) | Cognition & methods | Neuroscience & motor learning | Based on the bibliography title and research context. |
| Dead science: Most resources linked in biomedical articles disappear in eight years (`zeng2019dead`) | Research integrity, Science of science | Reproducibility & resource longevity, Dataset discovery & reuse | Based on the bibliography title and research context. |
| Finding datasets in publications: the Syracuse University approach (`zeng2020finding`) | Peer review & discovery | Dataset discovery & reuse, Text mining & NLP, Scholarly data & tools | Based on the bibliography title and research context. |
| Artificial mental phenomena: Psychophysics as a framework to detect perception biases in AI models (`liang2020artificial`) | Cognition & methods | AI bias & explainability, Perception & psychophysics | Based on the bibliography title and research context. |
| Assigning credit to scientific datasets using article citation networks (`zeng2020assigning`) | Peer review & discovery, Science of science | Dataset discovery & reuse, Citation analysis, Scholarly data & tools | Based on the bibliography title and research context. |
| Pubmed parser: a python parser for pubmed open-access XML subset and MEDLINE XML dataset XML dataset (`achakulvisut2020pubmed`) | Peer review & discovery | Scholarly data & tools, Text mining & NLP | Based on the bibliography title and research context. |
| Pyglmnet: Python implementation of elastic-net regularized generalized linear models (`jas2020pyglmnet`) | Cognition & methods | Statistical methods & software | Based on the bibliography title and research context. |
| Modeling citation worthiness by using attention-based bidirectional long short-term memory networks and interpretable models (`zeng2020modeling`) | Research integrity, Peer review & discovery | Citation practices, Text mining & NLP, Scholarly data & tools | The abstract explicitly covers omitted citations and pre-submission checks, so this also belongs to integrity. |
| An Automatic Misleading Graph Detection Tool (`zhuangacuna2020`) | Research integrity | Figure integrity, Graphical integrity | Based on the bibliography title and research context. Format override: inproceedings. |
| Are author, affiliation, and citation networks predictive of a journal getting blacklisted? (`liangacuna2020`) | Research integrity, Science of science | Questionable journals, Citation analysis | Based on the bibliography title and research context. Format override: inproceedings. |
| Don't judge a journal by its cover?: Appearance of a Journal's website as predictor of blacklisted Open-Access status (`liang2020don`) | Research integrity | Questionable journals | Based on the bibliography title and research context. Format override: inproceedings. |
| Large-scale author name disambiguation using approximate network structures (`zengacuna2020`) | Peer review & discovery, Science of science | Scholarly data & tools, Citation analysis | Based on the bibliography title and research context. Format override: inproceedings. |
| GotFunding: A grant recommendation system based on scientific articles (`zeng2020gotfunding`) | Peer review & discovery, Science of science | Research funding, Research recommendation, Recommender systems, Text mining & NLP | Based on the bibliography title and research context. Format override: inproceedings. |
| Are AI Ethics Conferences Different and More Diverse Compared to Traditional Computer Science Conferences? (`10.1145/3461702.3462616`) | Science of science | Diversity & inclusion, Responsible AI | A study of participation in AI ethics conferences, not a study of scientific misconduct. |
| Predicting the usage of scientific datasets based on article, author, institution, and journal bibliometrics (`acunaiconference2022`) | Science of science | Dataset discovery & reuse, Citation analysis | Based on the bibliography title and research context. |
| Graphical integrity issues in open access publications: detection and patterns of proportional ink violations (`zhuangacuna2021`) | Research integrity | Figure integrity, Graphical integrity | Based on the bibliography title and research context. |
| Author-suggested reviewers rate manuscripts much more favorably: A cross-sectional analysis of the neuroscience section of PLOS ONE (`acuna2022`) | Research integrity, Peer review & discovery, Science of science | Peer review, Review bias | Based on the bibliography title and research context. |
| A dataset of mentorship in bioscience with semantic and demographic estimations (`keacuna2022`) | Science of science | Mentorship, Scholarly data & tools, Diversity & inclusion | Based on the bibliography title and research context. |
| A computational analysis of accessibility, readability, and explainability of figures in open access publications (`zhuang2023computational`) | Research integrity, Science of science | Figure accessibility | Included in integrity for scientific communication quality; accessibility problems do not imply misconduct. |
| Incorporating costs and benefits to the evaluation of uncertain research results: applications to cancer research funding (`10.1162/qss_a_00332`) | Science of science, Cognition & methods | Research funding, Decision-making | Based on the bibliography title and research context. |
| Science Needs You: Mobilizing for Diversity in Award Recognition (`novoa2024science`) | Science of science | Diversity & inclusion, Scientific careers & recognition | Based on the bibliography title and research context. |
| MISTI: Metadata-Informed Scientific Text and Image Representation through Contrastive Learning (`taechoyotin2024misti`) | Peer review & discovery | Multimodal learning, Text mining & NLP, Scholarly data & tools | Scientific figure/caption retrieval, not peer-review generation or image-forensics research. |
| The impact of heterogeneous shared leadership in scientific teams (`XU2024103542`) | Science of science | Teams & collaboration, Diversity & inclusion | Based on the bibliography title and research context. |
| A First Step towards Measuring Interdisciplinary Engagement in Scientific Publications: A Case Study on NLP+ CSS Research (`leto2024first`) | Peer review & discovery, Science of science | Interdisciplinarity, Citation analysis, Text mining & NLP | Based on the bibliography title and research context. |
| RecSOI: recommending research directions using statements of ignorance (`Bibal2024`) | Peer review & discovery | Research recommendation, Recommender systems, Text mining & NLP | Based on the bibliography title and research context. |
| MAMORX: Multi-agent Multi-modal Scientific Review Generation with External Knowledge (`taechoyotin2024mamorx`) | Peer review & discovery | Peer review, Language models, Multimodal learning | Based on the bibliography title and research context. |
| Comparative Explanations for Recommendation: Research Directions (`varasteh2024comparative`) | Peer review & discovery, Cognition & methods | Recommender systems, AI bias & explainability, Human–computer interaction | General recommender-system explanations support discovery methods; not specifically scientific peer review. |
| Paraphrase Identification with Deep Learning: A Review of Datasets and Methods (`zhou2022paraphrase`) | Peer review & discovery, Cognition & methods | Text mining & NLP | A survey of paraphrase methods; the word review here does not make it a peer-review paper. |
| Predicting the longevity of resources shared in scientific publications (`acuna2022predicting`) | Research integrity, Science of science | Reproducibility & resource longevity, Dataset discovery & reuse | Based on the bibliography title and research context. |
| Estimating the predictability of questionable open-access journals (`zhuang2025estimating`) | Research integrity, Science of science | Questionable journals | Based on the bibliography title and research context. |
| Widespread reference missingness disparities in open scholarly metadata (`zhou2026widespread`) | Research integrity, Science of science | Metadata quality, Scholarly data & tools, Citation analysis, Diversity & inclusion | Integrity includes reliability of scholarly metadata; database omissions do not imply author misconduct. |
| Beyond a number game: Flat team structures improve inclusion and performance in diverse scientific teams (`xu2026beyond`) | Science of science | Teams & collaboration, Diversity & inclusion | Based on the bibliography title and research context. |
| Dissecting the gender divide: authorship and acknowledgment in scientific publications (`kusumegi2026dissecting`) | Science of science | Diversity & inclusion, Teams & collaboration, Scientific careers & recognition | Based on the bibliography title and research context. |
| SciIntBench: Measuring LLM Compliance with Research Integrity Norms Under Adversarial Framing (`meguimtsop2026sciintbench`) | Research integrity, Peer review & discovery | Responsible AI, Language models | Based on the bibliography title and research context. |
| REM-CTX: Automated Peer Review via Reinforcement Learning with Auxiliary Context (`taechoyotin2026remctx`) | Peer review & discovery | Peer review, Language models, Reinforcement learning, Multimodal learning | Based on the bibliography title and research context. |
| Government Funding and the Direction of Academic Energy Research (`popp2026government`) | Science of science | Research funding | Based on the bibliography title and research context. |
| REMOR: Automated Peer Review Generation with LLM Reasoning and Multi-Objective Reinforcement Learning (`taechoyotin2025remor`) | Peer review & discovery | Peer review, Language models, Reinforcement learning | Based on the bibliography title and research context. |
| The complementary contributions of academia and industry to AI research (`liang2024complementary`) | Science of science | Teams & collaboration | Based on the bibliography title and research context. |

## Verification

`npm test` checks regression cases against the real publication index and rejects missing, stale, empty, duplicated, or invalid metadata assignments. Tests cover all 70 full-title queries, the two originally broken queries, synonyms, overlapping topics, specific peer review, title/author/year combinations, and empty results.

The initial 56-record browser pass covered all four topic routes and all 32 tag routes, exact explorer/archive membership agreement, year/type/tag intersections, URL reload, back navigation, reset/focus, invalid parameters, and no-JavaScript readability. All 56 original custom explorer previews showed the corresponding paper title. Hover persistence, keyboard focus, Escape dismissal, and removal of native SVG titles passed. No page JavaScript errors were observed.

## Scholar additions: taxonomy rationale

| Record | Topics | Tags | Rationale |
| --- | --- | --- | --- |
| `lancichinetti2015topic` | discovery, foundations | text-mining, statistical-methods | Topic modeling and reliable computational methods; reproducibility here describes algorithm behavior, not an investigation of research misconduct. |
| `achakulvisut2019claim` | discovery, foundations | text-mining, scholarly-data | Assigned from the verified title and primary-source research description. |
| `liu2022team` | ecosystem | collaboration, citation-analysis | Assigned from the verified title and primary-source research description. |
| `achakulvisut2020neuromatch` | discovery, ecosystem | recommender-systems, collaboration, careers, text-mining | An eLife Labs web article, not a peer-reviewed eLife journal article. |
| `xiang2020tampering` | integrity, foundations | figure-integrity, image-forensics | Assigned from the verified title and primary-source research description. |
| `zhuang2019novelty` | ecosystem | funding, citation-analysis | Assigned from the verified title and primary-source research description. |
| `acuna2020mentorshipcommentary` | integrity, ecosystem | mentorship, diversity, statistical-methods | Methodological commentary on the interpretation of gender and mentorship evidence. The original OSF landing page is unavailable; link is the archived author manuscript exposed by Scholar. |
| `abatayo2026credibility` | integrity, ecosystem | reproducibility, statistical-methods | Research credibility, replicability, reproducibility, and robustness. Complete author list comes from the OSF citation API. |
| `acuna2021eileen` | discovery, ecosystem | research-recommendation, recommender-systems, funding, text-mining | Assigned from the verified title and primary-source research description. |
| `bu2022workshop` | ecosystem, discovery | scholarly-data | A published two-page workshop announcement. |
| `acuna2010aspiration` | foundations | decision-making, reinforcement-learning | Poster abstract, confirmed against the original conference program and Frontiers event abstract. |
| `acuna2020nullmodel` | integrity, foundations | figure-integrity, image-forensics, statistical-methods | Assigned from the verified title and primary-source research description. |
| `schrater2009structure` | foundations | decision-making, reinforcement-learning | Separate 2009 VSS abstract; do not merge with the 2008 NeurIPS paper or 2010 PLOS article. |
| `acuna2021mlworkshop` | discovery, ecosystem, foundations | scholarly-data, text-mining, statistical-methods | Existing lab workshop page confirms the year and authors; now indexed in Publications too. |

## Final verification after Scholar additions

The final browser pass used all 70 records. All 36 topic/tag routes matched their complete membership sets; all 70 explorer previews matched title and date metadata. Integrity returns 18 records and Peer review & discovery 24. Specific image forensics returns three. All three alternate-title searches find the existing canonical entry. The 2025 preprint filter finds REMOR; no 2050 or pre-2008 year is present. All 83 credibility-paper authors remain searchable and available through the native disclosure.

All 70 works are visible with JavaScript disabled. The six publication-format totals match the source metadata. Desktop and phone screenshots were inspected, with no horizontal overflow or local page JavaScript errors. All 35 distinct internal asset/page paths from the changed main routes exist. `npm test`, `npm run build`, and `git diff --check` passed. Detailed counts are in `final-publication-browser-checks.json`.
