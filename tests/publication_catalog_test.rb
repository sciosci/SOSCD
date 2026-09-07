require 'bibtex'
require 'yaml'
require_relative '../lib/publication_catalog'

entries = BibTeX.open('_bibliography/references.bib').entries.values
taxonomy = YAML.safe_load(File.read('_data/publication_taxonomy.yml'))
catalog = PublicationCatalog.new(entries, taxonomy)
raise 'Not every bibliography record is indexed' unless catalog.index.keys.sort == entries.map(&:key).sort
raise 'No overlapping topics found' unless catalog.index.values.any? { |record| record['topics'].size > 1 }

def rejects(entries, taxonomy, message)
  modified = Marshal.load(Marshal.dump(taxonomy))
  yield modified
  begin
    PublicationCatalog.new(entries, modified)
  rescue RuntimeError => error
    raise error unless error.message.include?(message)
    return
  end
  raise "Expected validation failure: #{message}"
end

rejects(entries, taxonomy, 'Missing publication taxonomy') { |data| data['papers'].delete(entries.first.key) }
rejects(entries, taxonomy, 'Unknown bibliography keys') { |data| data['papers']['nonexistent-paper'] = data['papers'].values.first }
rejects(entries, taxonomy, 'Invalid topics') { |data| data['papers'][entries.first.key]['topics'] = [] }
rejects(entries, taxonomy, 'Invalid topics') { |data| data['papers'][entries.first.key]['topics'] = ['typo-topic'] }
rejects(entries, taxonomy, 'Invalid tags') { |data| data['papers'][entries.first.key]['tags'] = ['typo-tag'] }
rejects(entries, taxonomy, 'Invalid tags') { |data| data['papers'][entries.first.key]['tags'] = ['peer-review', 'peer-review'] }
rejects(entries, taxonomy, 'Invalid format') { |data| data['papers'][entries.first.key]['format'] = 'unknown' }
raise 'Historical preprint misclassified' unless catalog.index['acuna2018bioscience']['format'] == 'preprint'
raise 'Conference abstract misclassified' unless catalog.index['zhuangacuna2020']['format'] == 'inproceedings'
raise 'Web article misclassified as journal article' unless catalog.index['achakulvisut2020neuromatch']['format'] == 'webarticle'
raise 'Preprint year lost' unless catalog.index['taechoyotin2025remor']['year_label'].start_with?('2025')
early_entries = BibTeX.parse(File.read('_bibliography/references.bib').sub('year = {2008}', 'year = {2007}')).entries.values
begin
  PublicationCatalog.new(early_entries, taxonomy)
  raise 'Accepted a record before the 2008 cutoff'
rescue RuntimeError => error
  raise error unless error.message.include?('Publication year must be 2008 or later')
end
puts "Publication taxonomy validation passed for #{entries.size} records, including missing/invalid metadata rejection."
