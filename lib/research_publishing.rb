require 'fileutils'
require 'json'

class ResearchPublishing
  def initialize(entries, catalog, details)
    @entries, @catalog, @details = entries, catalog, details
  end

  def write
    missing = @details.keys - @catalog.index.keys
    raise "Unknown paper overviews: #{missing.join(', ')}" unless missing.empty?
    paths = @details.values.map { |detail| detail.fetch('path') }
    raise 'Duplicate paper overview paths' unless paths.uniq == paths
    FileUtils.mkdir_p('publications/citations')
    FileUtils.mkdir_p('_pages/research-papers')
    exports = @entries.map do |entry|
      # Export bibliographic fields, not website-only HTML, image, or press metadata.
      fields = %i[title author editor year publication_date journal booktitle volume number pages publisher school doi url isbn issn note]
      clean = BibTeX::Entry.new(bibtex_type: entry.type, bibtex_key: entry.key)
      fields.each { |field| clean[field] = entry[field] if entry[field] }
      record = @catalog.index.fetch(entry.key)
      clean[:doi] = record['doi'] unless record['doi'].empty?
      clean[:url] = record['url'] unless record['url'].empty?
      content = clean.to_s.rstrip + "\n"
      File.write(record.fetch('bibtex_path').delete_prefix('/'), content)
      record['bibtex'] = content
      content
    end
    File.write('publications.bib', exports.join("\n"))

    @details.each do |key, detail|
      record = @catalog.index.fetch(key)
      raise "Missing editorial content: #{key}" unless %w[question summary findings methods limitations source_url reviewed_at].all? { |field| detail[field] && !detail[field].empty? }
      path = detail.fetch('path')
      filename = if path.end_with?('.html')
                   "_pages/publications/#{File.basename(path, '.html')}.md"
                 else
                   "_pages/research-papers/#{path.split('/').last}.md"
                 end
      authors = record.fetch('author_list').map do |author|
        { 'citation_author' => [author.fetch('family'), author.fetch('given')].reject(&:empty?).join(', ') }
      end
      front = {
        'layout' => 'research-paper', 'publication_key' => key,
        'title' => record.fetch('title'), 'description' => detail.fetch('summary'),
        'permalink' => path, 'last_modified_at' => detail.fetch('reviewed_at'),
        'citation_title' => record.fetch('title'), 'author_affiliation_list' => authors,
        'citation_year' => record.fetch('year'), 'citation_publication_date' => record.fetch('publication_date').tr('-', '/'),
        'citation_abstract' => detail['abstract'], 'citation_doi' => record['doi'],
        'citation_language' => 'en', 'citation_volume' => record['volume'], 'citation_issue' => record['issue'],
        'citation_firstpage' => record['pages'].split(/--|–|-/).first,
        'citation_keywords' => record.fetch('tags').map { |id| @catalog.facets.fetch('tags').fetch(id).fetch('label') }
      }
      front['citation_journal_title'] = record['venue'] if record['format'] == 'article'
      front['citation_conference_title'] = record['venue'] if record['format'] == 'inproceedings'
      pdf = record.fetch('resources').find { |resource| resource['type'] == 'pdf' }
      front['citation_pdf_url'] = pdf['url'] if pdf
      front.reject! { |_key, value| value.nil? || value == '' }
      File.write(filename, front.to_yaml + "---\n")
    end
    File.write('_data/publication_index.yml', @catalog.index.to_yaml)
    ordered_keys = @catalog.index.values.sort_by { |record| [record.fetch('year').to_i, record.fetch('publication_date'), record.fetch('title')] }.reverse.map { |record| record.fetch('key') }
    File.write('_data/publication_order.yml', ordered_keys.to_yaml)
    puts "Published #{@details.size} research overviews and #{@entries.size} BibTeX records."
  end
end
