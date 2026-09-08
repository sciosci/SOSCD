---
layout: research-paper
publication_key: taechoyotin2026remctx
title: 'REM-CTX: Automated Peer Review via Reinforcement Learning with Auxiliary Context'
description: REM-CTX extends review generation beyond manuscript text. It trains a
  language model to use auxiliary context and tests whether explicit correspondence
  rewards improve the grounding of generated reviews.
permalink: "/publications/rem-ctx/"
last_modified_at: '2026-09-07'
citation_title: 'REM-CTX: Automated Peer Review via Reinforcement Learning with Auxiliary
  Context'
author_affiliation_list:
- citation_author: Taechoyotin, Pawin
- citation_author: Acuna, Daniel E.
citation_year: '2026'
citation_publication_date: 2026/03/31
citation_abstract: 'Most automated peer review systems rely on textual manuscript
  content alone, leaving visual elements such as figures and external scholarly signals
  underutilized. We introduce REM-CTX, a reinforcement-learning system that incorporates
  auxiliary context into the review generation process via correspondence-aware reward
  functions. REM-CTX trains an 8B-parameter language model with Group Relative Policy
  Optimization (GRPO) and combines a multi-aspect quality reward with two correspondence
  rewards that explicitly encourage alignment with auxiliary context. Experiments
  on manuscripts across Computer, Biological, and Physical Sciences show that REM-CTX
  achieves the highest overall review quality among six baselines, outperforming other
  systems with substantially larger commercial models, and surpassing the next-best
  RL baseline across both quality and contextual grounding metrics. Ablation studies
  confirm that the two correspondence rewards are complementary: each selectively
  improves its targeted correspondence reward while preserving all quality dimensions,
  and the full model outperforms all partial variants. Analysis of training dynamics
  reveals that the criticism aspect is negatively correlated with other metrics during
  training, suggesting that future studies should group multi-dimension rewards for
  review generation.'
citation_doi: 10.48550/arXiv.2604.00248
citation_language: en
citation_keywords:
- Peer review
- Language models
- Reinforcement learning
- Multimodal learning
citation_pdf_url: https://arxiv.org/pdf/2604.00248
---
