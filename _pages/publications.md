---
layout: lab
title: "Publications"
permalink: /publications/
description: "Research papers, preprints, code, and datasets from the Science of Science & Computational Discovery Lab."
---
<main id="main" class="interior-main wrap">
  <header class="page-heading publication-heading"><div><h1>Publications.</h1><p>Publications, preprints, and the resources behind our research.</p></div><a class="text-link" href="https://scholar.google.com/citations?hl=en&user=GAi23ssAAAAJ&view_op=list_works&sortby=pubdate">Google Scholar {% include lab-arrow.html %}</a></header>
  <nav class="research-exports" aria-label="Publication resources"><a href="{{ '/research/' | relative_url }}">Explore the research topics</a><a href="{{ '/publications.bib' | relative_url }}" download>Download BibTeX</a><a href="{{ '/publications.json' | relative_url }}">Publication JSON</a><a href="{{ '/publications/feed.xml' | relative_url }}">Subscribe to the publication feed</a></nav>
  <div class="publication-tools" data-publication-tools hidden>
    <div class="search-row"><div class="publication-search"><label for="publication-search">Search publications</label><div class="search-input-wrap"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" aria-hidden="true"><circle cx="10.5" cy="10.5" r="6.5" stroke="currentColor" stroke-width="1.5"/><path d="m16 16 5 5" stroke="currentColor" stroke-width="1.5"/></svg><input type="search" id="publication-search" placeholder="Search by title, author, or topic" autocomplete="off"></div></div><div class="year-filter"><label for="publication-year">Year</label><select id="publication-year"><option value="all">All years</option></select></div></div>
    <div class="facet-row">
      <div class="publication-facet"><label for="publication-topic">Research topic</label><select id="publication-topic" aria-describedby="publication-topic-description"><option value="all">All research topics</option>{% for item in site.data.publication_facets.topics %}<option value="{{ item[0] }}">{{ item[1].label }} ({{ item[1].count }})</option>{% endfor %}</select></div>
      <div class="publication-facet"><label for="publication-tag">Specific tag</label><select id="publication-tag"><option value="all">All tags</option>{% for item in site.data.publication_facets.tags %}<option value="{{ item[0] }}">{{ item[1].label }} ({{ item[1].count }})</option>{% endfor %}</select></div>
    </div>
    <p class="topic-description" id="publication-topic-description">Browse by topic or a specific tag. Papers can belong to more than one topic.</p>
    <div class="filter-row"><div class="publication-filters" role="group" aria-label="Publication format or resource"><button type="button" data-filter="all" aria-pressed="true">All formats</button><button type="button" data-filter="article" aria-pressed="false">Journal articles</button><button type="button" data-filter="preprint" aria-pressed="false">Preprints</button><button type="button" data-filter="inproceedings" aria-pressed="false">Conferences &amp; workshops</button><button type="button" data-filter="incollection" aria-pressed="false">Chapters</button><button type="button" data-filter="phdthesis" aria-pressed="false">Theses</button><button type="button" data-filter="webarticle" aria-pressed="false">Web articles</button><button type="button" data-filter="code" aria-pressed="false">With code</button><button type="button" data-filter="dataset" aria-pressed="false">With data</button><button type="button" data-filter="demo" aria-pressed="false">With demo</button></div></div>
    <div class="publication-results-summary"><p id="publication-count" role="status" aria-live="polite"></p><button type="button" class="clear-publications" data-reset-publications hidden>Clear all filters</button></div>
  </div>
  <noscript><p>All publications are listed below. Enable JavaScript to search and filter the archive.</p></noscript>
  <div id="publication-results">
<!-- DO NOT REMOVE THIS LINE : BEGIN -->
<section class="publication-year" data-year="2026" aria-labelledby="year-2026">
  <h2 id="year-2026">2026</h2>
  {% bibliography --query @*[year=2026] %}
</section>

<section class="publication-year" data-year="2025" aria-labelledby="year-2025">
  <h2 id="year-2025">2025</h2>
  {% bibliography --query @*[year=2025] %}
</section>

<section class="publication-year" data-year="2024" aria-labelledby="year-2024">
  <h2 id="year-2024">2024</h2>
  {% bibliography --query @*[year=2024] %}
</section>

<section class="publication-year" data-year="2023" aria-labelledby="year-2023">
  <h2 id="year-2023">2023</h2>
  {% bibliography --query @*[year=2023] %}
</section>

<section class="publication-year" data-year="2022" aria-labelledby="year-2022">
  <h2 id="year-2022">2022</h2>
  {% bibliography --query @*[year=2022] %}
</section>

<section class="publication-year" data-year="2021" aria-labelledby="year-2021">
  <h2 id="year-2021">2021</h2>
  {% bibliography --query @*[year=2021] %}
</section>

<section class="publication-year" data-year="2020" aria-labelledby="year-2020">
  <h2 id="year-2020">2020</h2>
  {% bibliography --query @*[year=2020] %}
</section>

<section class="publication-year" data-year="2019" aria-labelledby="year-2019">
  <h2 id="year-2019">2019</h2>
  {% bibliography --query @*[year=2019] %}
</section>

<section class="publication-year" data-year="2018" aria-labelledby="year-2018">
  <h2 id="year-2018">2018</h2>
  {% bibliography --query @*[year=2018] %}
</section>

<section class="publication-year" data-year="2017" aria-labelledby="year-2017">
  <h2 id="year-2017">2017</h2>
  {% bibliography --query @*[year=2017] %}
</section>

<section class="publication-year" data-year="2016" aria-labelledby="year-2016">
  <h2 id="year-2016">2016</h2>
  {% bibliography --query @*[year=2016] %}
</section>

<section class="publication-year" data-year="2015" aria-labelledby="year-2015">
  <h2 id="year-2015">2015</h2>
  {% bibliography --query @*[year=2015] %}
</section>

<section class="publication-year" data-year="2014" aria-labelledby="year-2014">
  <h2 id="year-2014">2014</h2>
  {% bibliography --query @*[year=2014] %}
</section>

<section class="publication-year" data-year="2013" aria-labelledby="year-2013">
  <h2 id="year-2013">2013</h2>
  {% bibliography --query @*[year=2013] %}
</section>

<section class="publication-year" data-year="2012" aria-labelledby="year-2012">
  <h2 id="year-2012">2012</h2>
  {% bibliography --query @*[year=2012] %}
</section>

<section class="publication-year" data-year="2011" aria-labelledby="year-2011">
  <h2 id="year-2011">2011</h2>
  {% bibliography --query @*[year=2011] %}
</section>

<section class="publication-year" data-year="2010" aria-labelledby="year-2010">
  <h2 id="year-2010">2010</h2>
  {% bibliography --query @*[year=2010] %}
</section>

<section class="publication-year" data-year="2009" aria-labelledby="year-2009">
  <h2 id="year-2009">2009</h2>
  {% bibliography --query @*[year=2009] %}
</section>

<section class="publication-year" data-year="2008" aria-labelledby="year-2008">
  <h2 id="year-2008">2008</h2>
  {% bibliography --query @*[year=2008] %}
</section>
<!-- DO NOT REMOVE THIS LINE : END -->
  </div>
  <div class="publication-empty" hidden><h2>No matching publications.</h2><p>Try a broader topic, a different tag, or clear the filters to see all work.</p><button class="button button-primary" type="button" data-reset-publications>Clear search &amp; filters {% include lab-arrow.html %}</button></div>
  <script type="application/json" id="publication-taxonomy-data">{{ site.data.publication_facets | jsonify }}</script>
</main>
