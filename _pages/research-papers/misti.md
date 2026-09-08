---
layout: research-paper
publication_key: taechoyotin2024misti
title: 'MISTI: Metadata-Informed Scientific Text and Image Representation through
  Contrastive Learning'
description: MISTI learns joint representations of scientific figures, captions, and
  publication metadata. The study tests whether contextual information such as titles,
  sections, and concepts improves retrieval beyond the image-caption pair alone.
permalink: "/publications/misti/"
last_modified_at: '2026-09-07'
citation_title: 'MISTI: Metadata-Informed Scientific Text and Image Representation
  through Contrastive Learning'
author_affiliation_list:
- citation_author: Taechoyotin, Pawin
- citation_author: Acuna, Daniel
citation_year: '2024'
citation_publication_date: '2024'
citation_abstract: In scientific publications, automatic representations of figures
  and their captions can be used in NLP, computer vision, and information retrieval
  tasks. Contrastive learning has proven effective for creating such joint representations
  for natural scenes, but its application to scientific imagery and descriptions remains
  under-explored. Recent open-access publication datasets provide an opportunity to
  understand the effectiveness of this technique as well as evaluate the usefulness
  of additional metadata, which are available only in the scientific context. Here,
  we introduce MISTI, a novel model that uses contrastive learning to simultaneously
  learn the representation of figures, captions, and metadata, such as a paper’s title,
  sections, and curated concepts from the PubMed Open Access Subset. We evaluate our
  model on multiple information retrieval tasks, showing substantial improvements
  over baseline models. Notably, incorporating metadata doubled retrieval performance,
  achieving a Recall@1 of 30% on a 70K-item caption retrieval task. We qualitatively
  explore how metadata can be used to strategically retrieve distinctive representations
  of the same concept but for different sections, such as introduction and results.
  Additionally, we show that our model seamlessly handles out-of-domain tasks related
  to image segmentation. We share our dataset and methods (https://github.com/Khempawin/scientific-image-caption-pair/tree/section-attr)
  and outline future research directions.
citation_doi: 10.18653/v1/2024.sdp-1.15
citation_language: en
citation_firstpage: '155'
citation_keywords:
- Multimodal learning
- Text mining & NLP
- Scholarly data & tools
citation_conference_title: Proceedings of the Fourth Workshop on Scholarly Document
  Processing (SDP 2024)
citation_pdf_url: "/publications/misti/paper.pdf"
---
