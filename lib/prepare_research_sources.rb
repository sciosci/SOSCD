# One-time/editorial import from the cached primary records. Normal builds are offline.
require 'bibtex'
require 'yaml'
require 'json'
require 'nokogiri'

root = '.impeccable/research/seo-sources'
bibliography = BibTeX.open('_bibliography/references.bib')
text = File.read('_bibliography/references.bib')
details = YAML.safe_load(File.read('_data/publication_details.yml'))
legacy = {
  'zengacuna2020' => '_pages/publications/ic2s2-author-name-disambiguation.md',
  'acuna2022predicting' => '_pages/publications/predicting-the-longevity-of-resources-shared-in-scientific-publications.md'
}
details.each do |key, detail|
  metadata = nil
  entry = bibliography[key]
  source_key = key == '10.1162/qss_a_00332' ? 'zhuang2024costs' : key
  crossref_path = "#{root}/#{source_key}-crossref.json"
  if File.exist?(crossref_path)
    metadata = JSON.parse(File.read(crossref_path)).fetch('message')
    entry[:doi] = metadata.fetch('DOI')
    date = metadata.fetch('published').fetch('date-parts').first
    raise "Conflicting publication year for #{key}" unless date.first.to_s == entry[:year].to_s
    entry[:publication_date] = date.length == 3 ? date.map.with_index { |part, i| i.zero? ? part.to_s : format('%02d', part) }.join('-') : entry[:year].to_s
    detail['metadata_source'] = "https://api.crossref.org/works/#{metadata.fetch('DOI')}"
    if metadata['abstract'] && metadata.fetch('license', []).any? { |l| l['URL'].include?('creativecommons.org/licenses/by/4.0') }
      detail['abstract'] = Nokogiri::XML.fragment(metadata['abstract']).text.gsub(/\s+/, ' ').strip
      detail['abstract_license'] = 'https://creativecommons.org/licenses/by/4.0/'
    end
  end
  xml_path = "#{root}/#{source_key}-fulltext.xml"
  xml_path = "#{root}/structure-publisher.xml" if key == 'acuna2010structure' && !File.exist?(xml_path)
  if File.exist?(xml_path)
    document = Nokogiri::XML(File.read(xml_path))
    permissions = document.at_xpath('//permissions')&.to_xml.to_s
    license = permissions[/https?:\/\/creativecommons.org\/licenses\/[^"<\s]+/]
    if license || detail['abstract_license'] || (defined?(metadata) && metadata && metadata.fetch('license', []).any? { |l| l['URL'].include?('creativecommons.org/licenses/by/4.0') })
      detail['abstract_license'] = license ? license.sub('http:', 'https:') : 'https://creativecommons.org/licenses/by/4.0/'
      abstract = document.at_xpath('//article-meta/abstract')
      if abstract
        abstract = abstract.dup
        abstract.xpath('./title').remove
        detail['abstract'] = abstract.text.gsub(/\s+/, ' ').strip
      end
    end
    electronic = document.at_xpath('//article-meta/pub-date[@pub-type="epub" or @publication-format="electronic"]')
    if electronic && electronic.at_xpath('day')
      entry[:publication_date] = %w[year month day].map.with_index { |part, i| i.zero? ? electronic.at_xpath(part).text : format('%02d', electronic.at_xpath(part).text.to_i) }.join('-')
    end
  end
  arxiv_path = "#{root}/#{source_key}-arxiv.html"
  if File.exist?(arxiv_path)
    document = Nokogiri::HTML(File.read(arxiv_path))
    identifier = document.at_css('meta[name="citation_arxiv_id"]')['content']
    entry[:doi] = "10.48550/arXiv.#{identifier}"
    entry[:publication_date] = document.at_css('meta[name="citation_date"]')['content'].tr('/', '-')
    entry[:pdf_url] = "https://arxiv.org/pdf/#{identifier}"
    detail['metadata_source'] = "https://arxiv.org/abs/#{identifier}"
    license_link = document.css('a[href]').find { |a| a['href'].include?('creativecommons.org/licenses/') }
    if license_link
      detail['abstract'] = document.at_css('meta[name="citation_abstract"]')['content']
      detail['abstract_license'] = license_link['href'].sub('http:', 'https:')
    end
  end
  if legacy.key?(key)
    old = YAML.safe_load(File.read(legacy[key]).split(/^---\s*$\n/)[1])
    detail['abstract'] ||= old['citation_abstract']
    entry[:publication_date] = old['citation_publication_date'].tr('/', '-')
    entry[:doi] = old['citation_doi']
    entry[:pdf_url] = old['citation_pdf_url']
    detail['abstract_license'] = key == 'zengacuna2020' ? 'https://creativecommons.org/licenses/by/4.0/' : 'https://creativecommons.org/licenses/by-nc-nd/4.0/'
    detail['metadata_source'] = key == 'zengacuna2020' ? 'https://zenodo.org/records/4403705' : 'https://www.nature.com/articles/s41599-025-04716-z'
  end
  if key == 'taechoyotin2024misti'
    doc = Nokogiri::HTML(File.read("#{root}/misti-publisher.html"))
    abstract = doc.at_css('.acl-abstract > span')
    detail['abstract'] = abstract.text.strip if abstract
    detail['abstract_license'] = 'https://creativecommons.org/licenses/by/4.0/' if doc.to_html.include?('creativecommons.org/licenses/by/4.0')
    entry[:code] = 'https://github.com/Khempawin/scientific-image-caption-pair/tree/section-attr'
    entry[:pdf_url] = 'https://aclanthology.org/2024.sdp-1.15.pdf'
    detail['metadata_source'] = 'https://aclanthology.org/2024.sdp-1.15/'
  end
  if key == 'acuna2022predicting'
    entry[:code] = 'https://github.com/sciosci/predicting_resource_longevity/'
    entry[:preprint_url] = 'https://arxiv.org/abs/2203.12800'
  end
  entry[:paper_intro_url] = detail.fetch('path')
  detail['source_url'] = detail.fetch('metadata_source')
  # Each selected entry is updated in place; unrelated bibliography records are preserved.
  pattern = /@#{Regexp.escape(entry.type.to_s)}\{#{Regexp.escape(key)},.*?(?=\n@|\z)/m
  raise "Could not find bibliography entry #{key}" unless text.match?(pattern)
  text = text.sub(pattern) { entry.to_s + "\n" }
end
File.write('_bibliography/references.bib', text)
File.write('_data/publication_details.yml', details.to_yaml)
puts "Verified #{details.size} paper records; #{details.values.count { |d| !d['abstract'].to_s.empty? }} full abstracts with source/license attribution."
