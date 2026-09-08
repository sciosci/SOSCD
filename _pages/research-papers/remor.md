---
layout: research-paper
publication_key: taechoyotin2025remor
title: 'REMOR: Automated Peer Review Generation with LLM Reasoning and Multi-Objective
  Reinforcement Learning'
description: REMOR studies review generation with a reasoning language model and rewards
  for multiple aspects of review quality. It compares different reward designs and
  examines how training changes the feedback produced.
permalink: "/publications/remor/"
last_modified_at: '2026-09-07'
citation_title: 'REMOR: Automated Peer Review Generation with LLM Reasoning and Multi-Objective
  Reinforcement Learning'
author_affiliation_list:
- citation_author: Taechoyotin, Pawin
- citation_author: Acuna, Daniel E.
citation_year: '2025'
citation_publication_date: 2025/05/16
citation_abstract: 'AI-based peer review systems tend to produce shallow and overpraising
  suggestions compared to human feedback. Here, we evaluate how well a reasoning LLM
  trained with multi-objective reinforcement learning (REMOR) can overcome these limitations.
  We start by designing a multi-aspect reward function that aligns with human evaluation
  of reviews. The aspects are related to the review itself (e.g., criticisms, novelty)
  and the relationship between the review and the manuscript (i.e., relevance). First,
  we perform supervised fine-tuning of DeepSeek-R1-Distill-Qwen-7B using LoRA on PeerRT,
  a new dataset of high-quality top AI conference reviews enriched with reasoning
  traces. We then apply Group Relative Policy Optimization (GRPO) to train two models:
  REMOR-H (with the human-aligned reward) and REMOR-U (with a uniform reward). Interestingly,
  the human-aligned reward penalizes aspects typically associated with strong reviews,
  leading REMOR-U to produce qualitatively more substantive feedback. Our results
  show that REMOR-U and REMOR-H achieve more than twice the average rewards of human
  reviews, non-reasoning state-of-the-art agentic multi-modal AI review systems, and
  general commercial LLM baselines. We found that while the best AI and human reviews
  are comparable in quality, REMOR avoids the long tail of low-quality human reviews.
  We discuss how reasoning is key to achieving these improvements and release the
  Human-aligned Peer Review Reward (HPRR) function, the Peer Review Reasoning-enriched
  Traces (PeerRT) dataset, and the REMOR models, which we believe can help spur progress
  in the area.'
citation_doi: 10.48550/arXiv.2505.11718
citation_language: en
citation_keywords:
- Peer review
- Language models
- Reinforcement learning
citation_pdf_url: "/publications/remor/paper.pdf"
---
