require 'bibtex'
require 'yaml'
require 'cgi'
require_relative 'lib/publication_catalog'
require_relative 'lib/research_publishing'

# The bibliography remains the only source of publication facts.
entries = BibTeX.open('./_bibliography/references.bib').entries.values
entry_map = entries.to_h { |entry| [entry.key, entry] }
details = YAML.safe_load(File.read('_data/publication_details.yml'))
pdf_sources = YAML.safe_load(File.read('_data/paper_pdf_sources.yml'))
catalog = PublicationCatalog.new(entries, YAML.safe_load(File.read('_data/publication_taxonomy.yml')), details, pdf_sources)
ResearchPublishing.new(entries, catalog, details).write
File.write('_data/publication_index.yml', catalog.index.to_yaml)
File.write('_data/publication_facets.yml', catalog.facets.to_yaml)
File.write('_data/publication_lens.yml', catalog.index.transform_values { |record| record.select { |key, _value| %w[title authors_short year_label venue topics].include?(key) } }.to_yaml)
years = entries.map { |entry| entry[:year].to_s }.uniq.sort_by { |year| -year.to_i }
html = years.map do |year|
  <<~HTML
    <section class="publication-year" data-year="#{year}" aria-labelledby="year-#{year}">
      <h2 id="year-#{year}">#{year}</h2>
      {% bibliography --query @*[year=#{year}] %}
    </section>
  HTML
end.join("\n")
page = File.read('_pages/publications.md')
page = page.sub(/(<!-- DO NOT REMOVE THIS LINE : BEGIN -->).*?(<!-- DO NOT REMOVE THIS LINE : END -->)/m) { "#{$1}\n#{html}#{$2}" }
File.write('_pages/publications.md', page)

# A small, intentional selection; all bibliographic facts come from references.bib.
selection = [
  ['meguimtsop2026sciintbench', 'Research integrity'],
  ['taechoyotin2026remctx', 'AI for peer review'],
  ['kusumegi2026dissecting', 'Science of science'],
  ['zhuang2025estimating', 'Research integrity']
]
featured = selection.filter_map do |key, topic|
  entry = entry_map[key]
  next unless entry
  names = entry[:author].to_s.split(/\s+and\s+/).map do |name|
    parts = name.split(',').map(&:strip)
    parts.length > 1 ? "#{parts[1]} #{parts[0]}" : name
  end
  {
    'key' => key, 'topic' => topic, 'title' => entry[:title].to_s.delete('{}'),
    'url' => catalog.index.fetch(key)['page_path'] || entry[:url].to_s.gsub('\\_', '_'), 'authors' => catalog.index.fetch(key)['authors'],
    'venue' => (entry[:journal] || entry[:booktitle]).to_s,
    'status' => catalog.index.fetch(key).fetch('year_label')
  }
end
File.write('_data/featured_publications.yml', featured.to_yaml)

# A radial index, not a citation graph: each point links to one actual work.
# Radius uses actual publication years, including preprints.
sorted = entries.sort_by { |entry| [entry[:year].to_i, entry.key] }
first_year, last_year = years.map(&:to_i).minmax
nodes = sorted.each_with_index.map do |entry, i|
  year = entry[:year].to_i
  radius = 58 + (year - first_year).to_f / [last_year - first_year, 1].max * 148
  angle = i * 2.399963229728653
  x, y = 260 + Math.cos(angle) * radius, 242 + Math.sin(angle) * radius
  title = entry[:title].to_s.delete('{}')
  topics = catalog.index.fetch(entry.key).fetch('topics').join(' ')
  label = "#{title} (#{catalog.index.fetch(entry.key).fetch('year_label')})"
  href = CGI.escapeHTML(catalog.index.fetch(entry.key)['page_path'] || entry[:url].to_s.gsub('\\_', '_'))
  href = "{{ '/publications/##{entry.key}' | relative_url }}" if href.empty?
  <<~SVG
    <a href="#{href}" class="research-node" data-paper="#{CGI.escapeHTML(entry.key)}" data-topics="#{topics}" aria-label="#{CGI.escapeHTML(label)}"><circle class="node-target" cx="#{x.round(2)}" cy="#{y.round(2)}" r="11" fill="transparent"/><circle class="node-dot" cx="#{x.round(2)}" cy="#{y.round(2)}" r="#{catalog.index.fetch(entry.key).fetch('format') == 'preprint' ? 5.5 : 4}"/></a>
  SVG
end.join
File.write('_includes/research-nodes.html', nodes)
File.write('_data/publication_stats.yml', { 'total' => entries.size, 'first_year' => first_year, 'last_year' => last_year }.to_yaml)
puts "Generated #{entries.size} publications, #{years.size} year groups, and #{featured.size} selected works."
puts "Validated topic and tag assignments for all #{catalog.index.size} works."
