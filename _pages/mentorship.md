---
layout: lab
permalink: /mentorship/
title: "Mentorship in science: dataset and documentation"
description: "Download and use the open mentorship dataset: files, join keys, publication identifiers, citation, license, and a Python example."
dataset_id: mentorship
last_modified_at: "2026-09-07"
---
{% assign dataset = site.data.datasets.mentorship %}
<main id="main" class="interior-main wrap research-overview">
  <nav class="research-breadcrumbs" aria-label="Breadcrumb"><a href="{{ '/resources/' | relative_url }}">Resources</a><span aria-hidden="true">/</span><span>Mentorship dataset</span></nav>
  <header class="page-heading"><h1>Mentorship in science.</h1><p class="topic-intro">An open dataset connecting mentorship relationships, publications, and representations of research.</p><div class="resource-actions"><a class="button button-primary" href="{{ dataset.url }}" data-resource-type="dataset" data-publication-key="keacuna2022">Get the dataset {% include lab-arrow.html %}</a><a href="#quickstart">Start with the CSV files</a><a href="{{ '/publications/mentorship-dataset/' | relative_url }}">Read the research overview</a></div></header>
  <p>{{ dataset.creators | join: ', ' }}</p>
  <div class="dataset-facts"><span>Released {{ dataset.date_published | date: '%B %-d, %Y' }}</span><a href="{{ dataset.license }}">CC BY 4.0</a><a href="https://doi.org/{{ dataset.doi }}">DOI: {{ dataset.doi }}</a></div>
  <div class="research-prose">
    <section><h2>What is in the dataset?</h2><p>{{ dataset.description }}</p><p>The <a href="{{ '/publications/mentorship-dataset/' | relative_url }}">2022 Scientific Data paper</a> explains the construction and validation. The dataset release is dated 2021; its release date and the paper's publication date describe different records.</p></section>
    <section><h2>Start with the relationships</h2><p>Four CSV tables connect mentorship, researchers, authorship, and publication identifiers. Their column names are case-sensitive.</p><div class="data-table-wrap"><table class="data-table"><caption class="source-note">Core tables and join keys</caption><thead><tr><th scope="col">Table</th><th scope="col">What it contains</th></tr></thead><tbody><tr><td><code>mentorship.csv.gz</code></td><td><code>CID</code> identifies a relationship. <code>MenteeID</code> and <code>MentorID</code> link to a researcher's <code>PID</code>. Also includes mentorship type, institution, and start/stop years.</td></tr><tr><td><code>researcher.csv.gz</code></td><td>Researcher <code>PID</code>, names, institution, research area, ORCID, and MAG author identifier.</td></tr><tr><td><code>authorship.csv.gz</code></td><td>Links researcher <code>PID</code> to publication <code>MAGPaperID</code>.</td></tr><tr><td><code>paper.csv.gz</code></td><td>Links <code>MAGPaperID</code> to <code>DOI</code> and <code>PMID</code>, when available.</td></tr></tbody></table></div><p><code>MentorshipType</code> uses 0 for research assistant, 1 for graduate student, 2 for postdoctoral, 3 for research scientist, and 4 for collaborator. Missing dates or identifiers need explicit treatment in an analysis.</p></section>
    <section id="quickstart"><h2>A small first analysis</h2><p>With Python and pandas installed, download two core files and attach each mentee's research area to their mentorship records. The compressed downloads total about 25 MiB. This example does not require the embedding files.</p>
<pre><code>from urllib.request import urlretrieve
import pandas as pd

base = "https://zenodo.org/api/records/4917086/files"
for name in ("mentorship.csv.gz", "researcher.csv.gz"):
    urlretrieve(f"{base}/{name}/content", name)

relationships = pd.read_csv(
    "mentorship.csv.gz",
    usecols=["CID", "MenteeID", "MentorID", "MentorshipType"],
)
researchers = pd.read_csv(
    "researcher.csv.gz", usecols=["PID", "ResearchArea"]
)
mentees = researchers.rename(columns={"PID": "MenteeID"})
joined = relationships.merge(
    mentees, on="MenteeID", how="left", validate="many_to_one"
)
print(joined["ResearchArea"].value_counts(dropna=False).head())</code></pre>
    <p>To attach mentor attributes, rename <code>PID</code> to <code>MentorID</code> and join on that column instead. Check matching rates and missing values before interpreting group differences.</p></section>
    <section><h2>Coverage and responsible interpretation</h2><ul><li>The records are crowdsourced and do not represent a complete or uniform census of scientific mentorship. Coverage and validation are strongest in neuroscience and biomedical science.</li><li>Publication matching and semantic representations are estimates. Disambiguation errors and missing publications can affect downstream results.</li><li>Gender and race/ethnicity fields are name-based model estimates, not self-reported identities. They can be noisy and biased, and the categories do not describe the full range of individual identities.</li><li>Use these estimates with uncertainty and sensitivity analyses in aggregate research. They should not be used to decide an individual's identity, eligibility, or opportunity.</li><li>The release contains historical Microsoft Academic Graph identifiers. DOI and PMID provide additional routes to publication metadata.</li></ul><p>The paper describes some tables that are not present as separate files in this release. The download list below reflects the actual Zenodo record. Large embedding files are optional for the CSV example.</p></section>
    <section><h2>Cite the dataset</h2><p class="citation-text" id="dataset-citation">{{ dataset.citation | escape }}</p><div class="resource-actions"><button class="button button-primary" type="button" data-copy-citation="dataset-citation" hidden>Copy citation</button><a href="{{ '/datasets/mentorship.bib' | relative_url }}" download>Download dataset BibTeX</a></div><p class="copy-status" data-copy-status role="status" aria-live="polite"></p><p>Please also cite the <a href="{{ '/publications/mentorship-dataset/#cite' | relative_url }}">data descriptor</a> when using its construction or validation methods. The dataset is shared under <a href="{{ dataset.license }}">Creative Commons Attribution 4.0</a>; credit the creators and identify any changes.</p></section>
  </div>
  <section class="related-research" aria-labelledby="files"><h2 id="files">Download files</h2><p class="source-note">File names and compressed sizes come from <a href="{{ dataset.url }}">Zenodo record 4917086</a>. <a href="{{ '/datasets/mentorship.json' | relative_url }}">Download file metadata and checksums (JSON)</a>. The embedding matrices can be several GiB each.</p><div class="data-table-wrap"><table class="data-table"><thead><tr><th scope="col">File</th><th scope="col">Download size</th></tr></thead><tbody>{% for file in dataset.files %}<tr><td><a href="{{ file.url }}" data-resource-type="dataset" data-publication-key="keacuna2022"><code>{{ file.name }}</code></a></td><td class="file-size">{{ file.size_label }}</td></tr>{% endfor %}</tbody></table></div></section>
  <section class="research-close"><h2>Project support</h2><p>This project was partially supported by NSF grant <a href="https://www.nsf.gov/awardsearch/showAward?AWD_ID=1933803">1933803: Social Dynamics of Knowledge Transfer Through Scientific Mentorship and Publication</a>.</p><p>Explore more <a href="{{ '/research/science-of-science/' | relative_url }}">science-of-science research</a> or <a href="{{ '/resources/' | relative_url }}">lab code and datasets</a>.</p></section>
</main>
