require 'yaml'
require 'latex/decode'

# Editorial topic assignments are explicit and reviewed, never guessed from titles.
class PublicationCatalog
  attr_reader :index, :facets

  def self.plain(value)
    LaTeX.decode(value.to_s).delete('{}').gsub("ı́", 'í').unicode_normalize(:nfc).strip
  end

  def initialize(entries, taxonomy, details = {}, pdf_sources = {})
    topics = taxonomy.fetch('topics')
    tags = taxonomy.fetch('tags')
    papers = taxonomy.fetch('papers')
    keys = entries.map(&:key)
    missing = keys - papers.keys
    stale = papers.keys - keys
    raise "Missing publication taxonomy: #{missing.join(', ')}" unless missing.empty?
    raise "Unknown bibliography keys in taxonomy: #{stale.join(', ')}" unless stale.empty?

    [topics, tags].each do |definitions|
      definitions.each do |id, definition|
        raise "Invalid taxonomy ID: #{id}" unless id.match?(/\A[a-z][a-z0-9-]*\z/)
        raise "Missing label for #{id}" if definition.fetch('label', '').strip.empty?
        unless definition['aliases'].is_a?(Array) && definition['aliases'].all? { |item| item.is_a?(String) && !item.strip.empty? }
          raise "Invalid aliases for #{id}"
        end
      end
    end

    @index = entries.to_h do |entry|
      year = entry[:year].to_s
      raise "Publication year must be 2008 or later: #{entry.key}" unless year.match?(/\A\d{4}\z/) && year.to_i >= 2008
      assignment = papers.fetch(entry.key)
      { 'topics' => topics, 'tags' => tags }.each do |field, definitions|
        values = assignment[field]
        unless values.is_a?(Array) && !values.empty? && values.uniq == values && (values - definitions.keys).empty?
          raise "Invalid #{field} for #{entry.key}: #{values.inspect}"
        end
      end
      author_list = entry[:author].map do |name|
        given = self.class.plain(name.first)
        family = [name.prefix, name.last].map { |value| self.class.plain(value) }.reject(&:empty?).join(' ')
        suffix = self.class.plain(name.suffix)
        { 'name' => [given, family, suffix].reject(&:empty?).join(' '), 'given' => given, 'family' => family }
      end
      names = author_list.map { |author| author.fetch('name') }
      format = assignment.fetch('format', entry.type.to_s)
      raise "Invalid format for #{entry.key}: #{format}" unless %w[article inproceedings preprint incollection phdthesis webarticle].include?(format)
      format_label = entry[:note].to_s
      format_label = { 'preprint' => 'Preprint / working paper', 'webarticle' => 'Web article' }.fetch(format, '') if format_label.empty?
      year_label = [year, format_label].reject(&:empty?).join(' · ')
      detail = details.fetch(entry.key, {})
      doi = entry[:doi].to_s.gsub('\\_', '_').sub(%r{\Ahttps?://(?:dx\.)?doi.org/}i, '')
      slug = entry.key.downcase.gsub(/[^a-z0-9]+/, '-').sub(/-\z/, '')
      record = {
        'key' => entry.key, 'title' => self.class.plain(entry[:title]),
        'alternate_title' => self.class.plain(entry[:alternate_title]),
        'authors' => names.join(', '),
        'author_list' => author_list,
        'authors_short' => names.first(3).join(', ') + (names.length > 3 ? ', et al.' : ''),
        'year' => year,
        'year_label' => year_label, 'format' => format, 'format_label' => format_label,
        'venue' => self.class.plain(entry[:journal] || entry[:booktitle] || entry[:school] || entry[:howpublished]),
        'topics' => assignment.fetch('topics'), 'tags' => assignment.fetch('tags'),
        'doi' => doi, 'publication_date' => entry[:publication_date].to_s.empty? ? year : entry[:publication_date].to_s,
        'volume' => entry[:volume].to_s, 'issue' => entry[:number].to_s, 'pages' => entry[:pages].to_s,
        'publisher' => self.class.plain(entry[:publisher]),
        'url' => entry[:url].to_s.gsub('\\_', '_'),
        'page_path' => detail['path'],
        'bibtex_path' => "/publications/citations/#{slug}.bib",
        'summary' => detail['summary'], 'abstract' => detail['abstract'],
        'abstract_license' => detail['abstract_license'],
        'reviewed_at' => detail['reviewed_at'],
        'resources' => []
      }
      resource_fields = { 'pdf_url' => 'pdf', 'preprint_url' => 'preprint', 'code' => 'code', 'dataset_url' => 'dataset', 'demo' => 'demo' }
      resource_fields.each do |field, kind|
        value = entry[field.to_sym].to_s.gsub('\\_', '_')
        if kind == 'pdf' && pdf_sources.key?(entry.key)
          source = pdf_sources.fetch(entry.key)
          value = source['status'] == 'mirrored' ? source.fetch('path') : source.fetch('source_url')
        end
        record['resources'] << { 'type' => kind, 'url' => value } unless value.empty?
      end
      record['citation'] = "#{names.join(', ')} (#{year}). #{record['title']}. #{record['venue']}." + (doi.empty? ? '' : " https://doi.org/#{doi}")
      [entry.key, record]
    end
    paths = @index.values.map { |record| record.fetch('bibtex_path') }
    raise 'Duplicate BibTeX download paths' unless paths.uniq == paths
    @facets = { 'topics' => topics, 'tags' => tags }.to_h do |field, definitions|
      [field, definitions.to_h do |id, definition|
        [id, definition.merge('count' => @index.values.count { |record| record[field].include?(id) })]
      end]
    end
    @facets['tags'] = @facets.fetch('tags').sort_by { |_id, definition| definition.fetch('label').downcase }.to_h
  end
end
