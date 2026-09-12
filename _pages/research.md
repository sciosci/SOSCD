---
layout: lab
title: "Research"
description: "Explore research integrity, AI-assisted peer review, scientific discovery, mentorship, and decision-making at the SOS+CD Lab, CU Boulder."
permalink: /research/
last_modified_at: "2026-09-12"
---
<main id="main" class="interior-main wrap research-overview">
  <header class="page-heading"><h1>Science, examined.</h1><p class="topic-intro">We study how research is produced, evaluated, and used—and develop computational methods to help it work better.</p></header>
  {% for item in site.data.research_topics %}{% assign topic_id = item[0] %}{% assign topic = item[1] %}<section class="topic-row"><div><h2><a href="{{ topic.path | relative_url }}">{{ topic.title }}</a></h2><span class="topic-count">{{ site.data.publication_facets.topics[topic_id].count }} works in the archive</span></div><div><p>{{ topic.intro }}</p><a class="text-link" href="{{ topic.path | relative_url }}">Explore {{ topic.title | downcase }} {% include lab-arrow.html %}</a></div></section>{% endfor %}
  <section class="research-close"><h2>From a question to the evidence.</h2><p>Paper overviews connect the research question, methods, findings, and limitations to the original work. The full archive includes publications and preprints from 2008 onward; papers can belong to more than one topic.</p><div class="resource-actions"><a class="button button-primary" href="{{ '/publications/' | relative_url }}">Browse publications {% include lab-arrow.html %}</a><a href="{{ '/resources/' | relative_url }}">Code, data, and citation downloads</a></div></section>
  <section class="research-close"><h2>Supporting the work</h2><p>See the <a href="{{ '/funding/' | relative_url }}">grants and projects supporting our research</a> or explore <a href="{{ '/openings/' | relative_url }}">information about joining the lab</a>.</p></section>
</main>
