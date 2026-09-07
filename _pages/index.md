---
layout: lab
title: "SOS+CD Lab at CU Boulder"
permalink: /
description: "We study how science works—and build computational tools to help it work better. A research lab at the University of Colorado Boulder."
---
<main id="main">
  <section class="home-hero wrap" aria-labelledby="hero-title">
    <div class="hero-copy">
      <h1 id="hero-title">Science is<br>our <span>subject.</span></h1>
      <p class="hero-intro">We study how science works.<br>And build tools to help it work better.</p>
      <p class="hero-description">The Science of Science &amp; Computational Discovery Lab at the University of Colorado Boulder.</p>
      <a class="button button-primary" href="{{ '/publications/' | relative_url }}">Explore our research {% include lab-arrow.html %}</a>
    </div>
    {% include research-lens.html %}
  </section>

  <a class="opportunity-strip" href="{{ '/openings/' | relative_url }}"><span class="wrap opportunity-inner"><span class="status-dot" aria-hidden="true"></span><span><strong>A place for your next question.</strong> One Ph.D. opening for Fall 2027.</span><span class="opportunity-action">Join the lab {% include lab-arrow.html %}</span></span></a>

  <section class="research-section wrap section-space" id="research" aria-labelledby="research-heading">
    <div class="section-heading"><h2 id="research-heading">Better questions.<br>Better science.</h2><p>From the integrity of a single figure to the structure of the scientific community, we examine the systems that shape discovery.</p></div>
    <div class="research-rows">
      <a class="research-row" href="{{ '/funding/#research-integrity' | relative_url }}"><div class="research-symbol" aria-hidden="true"><svg viewBox="0 0 72 72" fill="none"><path d="M36 9 58 18v17c0 14-10 23-22 28C24 58 14 49 14 35V18L36 9Z" stroke="currentColor" stroke-width="1.5"/><path d="m25 35 8 8 15-17" stroke="currentColor" stroke-width="2"/></svg></div><h3>Can we trust<br>the scientific record?</h3><div><span class="research-topic">Research integrity</span><p>Detecting image manipulation, evaluating questionable journals, and examining integrity in AI-generated research.</p></div>{% include lab-arrow.html %}</a>
      <a class="research-row" href="{{ '/funding/#peer-review' | relative_url }}"><div class="research-symbol" aria-hidden="true"><svg viewBox="0 0 72 72" fill="none"><rect x="17" y="9" width="33" height="47" rx="2" stroke="currentColor" stroke-width="1.5"/><path d="M25 21h17M25 29h17M25 37h10M31 63h27V24" stroke="currentColor" stroke-width="1.5"/><circle cx="48" cy="46" r="11" fill="var(--surface)" stroke="currentColor" stroke-width="1.5"/><path d="m44 46 3 3 6-7" stroke="currentColor" stroke-width="1.5"/></svg></div><h3>How can AI help<br>science move forward?</h3><div><span class="research-topic">Computational discovery</span><p>Developing methods for peer review, knowledge extraction, and research recommendation.</p></div>{% include lab-arrow.html %}</a>
      <a class="research-row" href="{{ '/funding/#science-of-science' | relative_url }}"><div class="research-symbol" aria-hidden="true"><svg viewBox="0 0 72 72" fill="none"><path d="m19 19 34 3-17 32L19 19Zm17 35L9 42m27 12 26-8M19 19l17-9" stroke="currentColor" stroke-width="1.5"/><g fill="var(--surface)" stroke="currentColor" stroke-width="1.5"><circle cx="19" cy="19" r="6"/><circle cx="53" cy="22" r="6"/><circle cx="36" cy="54" r="7"/><circle cx="9" cy="42" r="4"/><circle cx="62" cy="46" r="4"/><circle cx="36" cy="10" r="4"/></g></svg></div><h3>Who gets to<br>shape discovery?</h3><div><span class="research-topic">Science of science</span><p>Understanding how mentorship, funding, collaboration, and inequality influence the research ecosystem.</p></div>{% include lab-arrow.html %}</a>
    </div>
  </section>

  <section class="selected-section section-space" aria-labelledby="selected-heading">
    <div class="wrap"><div class="section-heading"><h2 id="selected-heading">Ideas in the making.</h2><a class="text-link" href="{{ '/publications/' | relative_url }}">All publications {% include lab-arrow.html %}</a></div>
      <div class="selected-publications">
      {% for paper in site.data.featured_publications %}
        <article class="selected-paper"><h3><a href="{{ paper.url }}">{{ paper.title }}</a></h3><div class="paper-meta"><span>{{ paper.topic }}</span><span>{{ paper.status }}</span></div><p>{{ paper.authors }}</p><div class="paper-bottom"><span>{{ paper.venue }}</span><a href="{{ paper.url }}" aria-label="Read {{ paper.title | escape }}">{% include lab-arrow.html %}</a></div></article>
      {% endfor %}
      </div>
    </div>
  </section>

  <section class="people-preview wrap section-space" aria-labelledby="people-heading">
    <div class="people-preview-copy"><h2 id="people-heading">Curiosity is<br>a team effort.</h2><p>We bring computational methods and a shared interest in science to questions that cross disciplinary boundaries.</p><a class="text-link" href="{{ '/people/' | relative_url }}">Meet the people {% include lab-arrow.html %}</a></div>
    <div class="portrait-strip">
      <a href="{{ '/people/#principal-investigator' | relative_url }}"><img src="{{ '/assets/images/lab/daniel.webp' | relative_url }}" alt="Daniel Acuña" width="320" height="400" loading="lazy"><span>Daniel Acuña<small>Principal investigator</small></span></a>
      <a href="{{ '/people/#doctoral-students' | relative_url }}"><img src="{{ '/assets/images/lab/carolina.webp' | relative_url }}" alt="Carolina Chávez-Ruelas" width="320" height="400" loading="lazy"><span>Carolina Chávez-Ruelas<small>Doctoral student</small></span></a>
      <a href="{{ '/people/#doctoral-students' | relative_url }}"><img src="{{ '/assets/images/lab/pawin.webp' | relative_url }}" alt="Pawin Taechoyotin" width="320" height="400" loading="lazy"><span>Pawin Taechoyotin<small>Doctoral student</small></span></a>
    </div>
  </section>

  <section class="news-section wrap section-space" id="news" aria-labelledby="news-heading"><div class="section-heading"><h2 id="news-heading">From the lab.</h2><a class="text-link" href="{{ '/news/' | relative_url }}">All news &amp; events {% include lab-arrow.html %}</a></div>{% include lab-news-preview.html %}</section>

  <section class="join-section wrap" aria-labelledby="join-heading"><div><h2 id="join-heading">What would you<br>like to discover?</h2><p>Bring your questions. Help us understand and improve science.</p></div><div class="join-details"><p>Ph.D. applications for Fall 2027<br><strong>Apply by December 15, 2026</strong></p><a class="button button-light" href="{{ '/openings/' | relative_url }}">Find your place in the lab {% include lab-arrow.html %}</a></div></section>
  <div class="support-invitation wrap"><div><h2>Help the next idea take shape.</h2><p>Support our mission to understand and improve science.</p></div><a class="text-link" href="{{ '/support/' | relative_url }}">Support the lab {% include lab-arrow.html %}</a></div>
</main>
