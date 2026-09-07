require 'yaml'

# Editorial topic assignments are explicit and reviewed, never guessed from titles.
class PublicationCatalog
  attr_reader :index, :facets

  def initialize(entries, taxonomy)
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
      names = entry[:author].to_s.split(/\s+and\s+/).map do |name|
        parts = name.split(',').map(&:strip)
        parts.length > 1 ? "#{parts[1]} #{parts[0]}" : name
      end
      format = assignment.fetch('format', entry.type.to_s)
      raise "Invalid format for #{entry.key}: #{format}" unless %w[article inproceedings preprint incollection phdthesis webarticle].include?(format)
      format_label = entry[:note].to_s
      format_label = { 'preprint' => 'Preprint / working paper', 'webarticle' => 'Web article' }.fetch(format, '') if format_label.empty?
      year_label = [year, format_label].reject(&:empty?).join(' · ')
      record = {
        'key' => entry.key, 'title' => entry[:title].to_s.delete('{}'),
        'alternate_title' => entry[:alternate_title].to_s,
        'authors' => names.join(', '),
        'authors_short' => names.first(3).join(', ') + (names.length > 3 ? ', et al.' : ''),
        'year' => year,
        'year_label' => year_label, 'format' => format, 'format_label' => format_label,
        'venue' => (entry[:journal] || entry[:booktitle] || entry[:school] || entry[:howpublished]).to_s,
        'topics' => assignment.fetch('topics'), 'tags' => assignment.fetch('tags')
      }
      [entry.key, record]
    end
    @facets = { 'topics' => topics, 'tags' => tags }.to_h do |field, definitions|
      [field, definitions.to_h do |id, definition|
        [id, definition.merge('count' => @index.values.count { |record| record[field].include?(id) })]
      end]
    end
    @facets['tags'] = @facets.fetch('tags').sort_by { |_id, definition| definition.fetch('label').downcase }.to_h
  end
end
