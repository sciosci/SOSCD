---
title: "Science of Science and Computational Discovery Laboratory"
excerpt: "<a href='https://www.colorado.edu/cs/'>Department of Computer Science</a>
<br /><a href='https://www.colorado.edu/'>University of Colorado Boulder</a>"
layout: splash
permalink: /
description: Trying to understand science and developing methods to mine scientific knowledge from vast, unstructured dataset of full-text publications, citations, and images
header:
  image: /assets/images/splash_images/cs_cub_midjourney.png
  caption: "Computer Science Laboratory in CU Boulder, Midjourney"
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/splash_images/cs_cub_midjourney.png
  actions:    
    - label: "News"
      url: "#news"
    - label: "About"
      url: "about"
feature_row:
  - image_path: assets/images/splash_images/publications_mj.jpg
    alt: "Publications"
    title: "Publications"
    excerpt: "See our latest publications"
    url: "publications"
    btn_label: "Publications"
    btn_class: "btn--primary"
  - image_path: assets/images/splash_images/code_mj.jpg
    alt: "Code"
    title: "Code"
    excerpt: "Browse our code on Github"
    url: "https://github.com/sciosci"
    btn_label: "ScioSci Github"
    btn_class: "btn--primary"
  - image_path: assets/images/splash_images/data_mj.jpg
    alt: "Datasets"
    title: "Datasets"
    excerpt: "Datasets enable new and better science."
    url: "mentorship"
    btn_label: "Datasets"
    btn_class: "btn--primary"
#feature_row2: 
#  - excerpt: 'Our lab is recruiting passionate minds! We try to understand and improve science by developing methods to mine knowledge from massive datasets, using cutting-edge techniques like deep learning, natural language processing, and more. Our Ph.D. program is fully-funded with deadline on December 15, 2023 [Read more](openings)'
#  - image_path: assets/images/splash_images/lab_members.png

feature_row2:
  - image_path: assets/images/splash_images/lab_members3.png
    alt: "We are recruiting!"
    image_caption: "Midjourney"
    title: "We are recruiting!"
    excerpt: 'We try to understand and improve science by developing methods to mine knowledge from massive datasets, using cutting-edge techniques like deep learning, natural language processing, and more. **Our Ph.D. program is fully-funded with deadline on December 15, 2023**'
    url: "openings"
    btn_label: "Read More"
    btn_class: "btn--primary"
---

{: .text-center}

<style>

  .btn--primary.disabled {
    opacity: 0.5;
    pointer-events: none;
    cursor: not-allowed;
  }
</style>

{% include feature_row %}

{% include_relative news.md %}
