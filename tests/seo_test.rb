# Run after a production build: bundle exec ruby tests/seo_test.rb [destination]
require 'json'
require 'nokogiri'
require 'minitest/autorun'
require 'uri'
require 'yaml'
require 'bibtex'
require 'digest'
require 'date'

SEO_DESTINATION = File.expand_path(ARGV.shift || '_site')

class SeoTest < Minitest::Test
  ORIGIN = 'https://scienceofscience.org'.freeze
  CATALOG = YAML.safe_load(File.read('_data/publication_index.yml')).freeze
  DETAILS = YAML.safe_load(File.read('_data/publication_details.yml')).freeze

  def document(path)
    file = File.join(SEO_DESTINATION, path.delete_prefix('/'))
    file = File.join(file, 'index.html') if File.directory?(file)
    file += '.html' if !File.exist?(file) && File.extname(file).empty?
    Nokogiri::HTML(File.read(file))
  end

  def meta(doc, name)
    doc.at_css("meta[name='#{name}']")&.[]('content')
  end

  def graph(doc)
    JSON.parse(doc.at_css('script[type="application/ld+json"]').text).fetch('@graph')
  end

  def sitemap_urls
    Nokogiri::XML(File.read(File.join(SEO_DESTINATION, 'sitemap.xml')))
      .remove_namespaces!.xpath('//loc').map(&:text)
  end

  def test_indexable_pages_have_consistent_metadata_and_entities
    paths = sitemap_urls.reject { |url| url.end_with?('.pdf') }.map { |url| URI(url).path }
    expected_new = DETAILS.values.map { |detail| detail.fetch('path') } +
      YAML.safe_load(File.read('_data/research_topics.yml')).values.map { |topic| topic.fetch('path') } + ['/research/', '/resources/']
    assert_equal 10 + expected_new.size, paths.size
    assert_empty expected_new - paths
    assert_equal paths.uniq, paths
    assert_includes paths, '/publications/'
    paths.each do |path|
      doc = document(path)
      assert_equal 1, doc.css('h1').size, path
      assert_equal ORIGIN + path, doc.at_css('link[rel="canonical"]')['href'], path
      refute_empty doc.at_css('title').text, path
      refute_empty meta(doc, 'description'), path
      refute_match(/noindex/, meta(doc, 'robots').to_s, path)
      image_url = doc.at_css('meta[property="og:image"]')['content']
      assert_equal ORIGIN, "#{URI(image_url).scheme}://#{URI(image_url).host}", path
      assert File.file?(File.join(SEO_DESTINATION, URI(image_url).path.delete_prefix('/'))), path
      entities = graph(doc)
      lab = entities.find { |entity| entity['@type'] == 'ResearchOrganization' }
      assert_equal 'Science of Science & Computational Discovery Lab', lab.fetch('name'), path
      assert_equal ORIGIN + '/#organization', lab.fetch('@id'), path
      assert_equal ORIGIN + '/#website', entities.find { |entity| entity['@type'] == 'WebSite' }.fetch('@id'), path
    end
  end

  def test_paper_citations_match_the_visible_work_and_correct_version
    {
      '/publications/predicting-the-longevity-of-resources-shared-in-scientific-publications.html' =>
        ['2025', '2025-05-22', '10.1057/s41599-025-04716-z', ['Acuna, Daniel E.', 'Jian, Jian', 'Zeng, Tong', 'Liang, Lizhen', 'Zhuang, Han']],
      '/publications/ic2s2-author-name-disambiguation.html' =>
        ['2020', '2020-07-17', '10.5281/zenodo.4403705', ['Zeng, Tong', 'Acuna, Daniel E']]
    }.each do |path, (year, date, doi, authors)|
      doc = document(path)
      assert_equal year, meta(doc, 'citation_year')
      assert_equal date, meta(doc, 'citation_publication_date').tr('/', '-')
      assert_equal doi, meta(doc, 'citation_doi')
      assert_equal authors, doc.css('meta[name="citation_author"]').map { |tag| tag['content'] }
      article = graph(doc).find { |entity| entity['@type'] == 'ScholarlyArticle' }
      assert_equal date, article.fetch('datePublished')
      assert_equal doi, article.fetch('identifier').fetch('value')
      assert_equal authors, article.fetch('author').map { |author| author.fetch('name') }
      assert_equal meta(doc, 'citation_title'), doc.at_css('h1').text.strip
      assert_equal meta(doc, 'citation_title'), article.fetch('headline')
    end
  end

  def test_all_research_pages_share_verified_citation_facts
    assert_operator DETAILS.size, :>=, 15
    DETAILS.each do |key, detail|
      paper = CATALOG.fetch(key)
      doc = document(detail.fetch('path'))
      article = graph(doc).find { |entity| entity['@type'] == 'ScholarlyArticle' }
      assert_equal paper.fetch('title'), doc.at_css('h1').text.strip, key
      assert_equal paper.fetch('title'), meta(doc, 'citation_title'), key
      if paper.fetch('doi').empty?
        assert_nil meta(doc, 'citation_doi'), key
      else
        assert_equal paper.fetch('doi'), meta(doc, 'citation_doi'), key
      end
      assert_equal paper.fetch('publication_date'), meta(doc, 'citation_publication_date').tr('/', '-'), key
      assert_equal paper.fetch('year'), meta(doc, 'citation_year'), key
      expected_authors = paper.fetch('author_list').map { |author| [author.fetch('family'), author.fetch('given')].reject(&:empty?).join(', ') }
      assert_equal expected_authors, doc.css('meta[name="citation_author"]').map { |tag| tag['content'] }, key
      assert_equal expected_authors, article.fetch('author').map { |author| author.fetch('name') }, key
      assert_equal paper.fetch('publication_date'), article.fetch('datePublished'), key
      assert_equal paper.fetch('citation'), doc.at_css('#paper-citation').text, key
      assert_equal key, doc.at_css('[data-copy-citation]')['data-publication-key'], key
      if detail['reuse']
        assert_includes doc.at_css('#reuse').parent.text, detail.fetch('reuse'), key
      end
      refute_empty doc.at_css('#scope').parent.text, key
      assert_equal 3, doc.css('.related-research .research-paper-row').size, key
      if detail['abstract']
        assert_equal detail.fetch('abstract'), meta(doc, 'citation_abstract'), key
        assert_includes doc.at_css('#abstract').parent.text, detail.fetch('abstract'), key
        assert_match(%r{https://creativecommons.org/licenses/}, detail.fetch('abstract_license'), key)
      else
        assert_nil meta(doc, 'citation_abstract'), key
        refute article.key?('abstract'), key
      end
    end
  end

  def test_topic_hubs_link_the_selected_papers_and_complete_archive
    topics = YAML.safe_load(File.read('_data/research_topics.yml'))
    facets = YAML.safe_load(File.read('_data/publication_facets.yml')).fetch('topics')
    overview = document('/research/')
    expected_counts = topics.keys.map { |key| "#{facets.fetch(key).fetch('count')} works in the archive" }
    assert_equal expected_counts, overview.css('.topic-count').map(&:text)
    topics.each do |key, topic|
      doc = document(topic.fetch('path'))
      topic.fetch('selected').each do |paper_key|
        assert doc.at_css("a[href='#{CATALOG.fetch(paper_key).fetch('page_path')}']"), paper_key
      end
      assert_includes doc.at_css('.resource-actions .button-primary').text, "Browse all #{facets.fetch(key).fetch('count')} works"
    end
  end

  def test_local_pdfs_keep_original_bytes_and_share_the_paper_directory
    sources = YAML.safe_load(File.read('_data/paper_pdf_sources.yml'))
    local = sources.select { |_key, source| source['status'] == 'mirrored' }
    assert_operator local.size, :>=, 10
    local.each do |key, source|
      body = File.binread(File.join(SEO_DESTINATION, source.fetch('path').delete_prefix('/')))
      assert body.start_with?('%PDF-'), key
      assert_operator body.bytesize, :<=, 5_000_000, key
      assert_equal source.fetch('sha256'), Digest::SHA256.hexdigest(body), key
      page_path = DETAILS.fetch(key).fetch('path')
      html_directory = page_path.end_with?('/') ? page_path.chomp('/') : File.dirname(page_path)
      assert_equal html_directory, File.dirname(source.fetch('path')), key
      doc = document(page_path)
      assert_equal ORIGIN + source.fetch('path'), meta(doc, 'citation_pdf_url'), key
      assert doc.at_css("a[href='#{source.fetch('license')}']"), key
    end
  end

  def test_exports_and_bibtex_cover_every_publication_without_older_records
    export = JSON.parse(File.read(File.join(SEO_DESTINATION, 'publications.json')))
    assert_equal CATALOG.size, export.fetch('record_count')
    records = export.fetch('publications')
    assert_equal CATALOG.keys.sort, records.map { |paper| paper.fetch('id') }.sort
    assert_equal 2008, records.map { |paper| paper.fetch('year').to_i }.min
    assert_equal DETAILS.size, records.count { |paper| paper['page_url'] }
    assert_equal DETAILS.values.count { |detail| detail['abstract'] }, records.count { |paper| paper['abstract'] }
    assert_equal CATALOG.size, BibTeX.open(File.join(SEO_DESTINATION, 'publications.bib')).entries.size
    records.each do |record|
      expected = CATALOG.fetch(record.fetch('id'))
      assert_equal expected.fetch('author_list'), record.fetch('authors'), record['id']
      assert_equal expected.fetch('topics'), record.fetch('topics'), record['id']
      assert_equal expected.fetch('tags'), record.fetch('tags'), record['id']
      refute_match(%r{doi\.org/}, record.fetch('doi'), record['id'])
      path = URI(record.fetch('bibtex_url')).path.delete_prefix('/')
      entries = BibTeX.open(File.join(SEO_DESTINATION, path)).entries.values
      assert_equal 1, entries.size, record['id']
      assert_equal record.fetch('id'), entries.first.key
      assert_equal record.fetch('year'), entries.first[:year].to_s
    end
    assert_equal records.size, records.map { |record| record.fetch('bibtex_url') }.uniq.size
  end

  def test_news_and_publication_feeds_have_real_stable_records
    { 'feed.xml' => YAML.safe_load(File.read('_data/news_feed.yml')).size, 'publications/feed.xml' => CATALOG.size }.each do |path, expected_count|
      feed = Nokogiri::XML(File.read(File.join(SEO_DESTINATION, path))) { |config| config.strict }
      ns = { 'atom' => 'http://www.w3.org/2005/Atom' }
      entries = feed.xpath('//atom:entry', ns)
      assert_equal expected_count, entries.size, path
      ids = entries.map { |entry| entry.at_xpath('atom:id', ns).text }
      assert_equal ids.size, ids.uniq.size, path
      entries.each do |entry|
        refute_empty entry.at_xpath('atom:title', ns).text, path
        assert DateTime.iso8601(entry.at_xpath('atom:updated', ns).text), path
        assert entry.at_xpath('atom:link', ns)['href'].start_with?(ORIGIN), path
      end
      refute_includes sitemap_urls, ORIGIN + '/' + path
    end
    feed = Nokogiri::XML(File.read(File.join(SEO_DESTINATION, 'publications/feed.xml'))).remove_namespaces!
    assert_equal CATALOG.values.count { |paper| paper.fetch('publication_date').size == 10 }, feed.xpath('//entry/published').size
    assert_includes feed.at_xpath('//entry/summary').text, '2026'
  end

  def test_dataset_schema_matches_the_release_and_downloads
    doc = document('/mentorship/')
    data = JSON.parse(File.read(File.join(SEO_DESTINATION, 'datasets/mentorship.json')))
    dataset = graph(doc).find { |entity| entity['@type'] == 'Dataset' }
    assert_equal '2021-06-09', dataset.fetch('datePublished')
    assert_equal 'https://doi.org/10.5281/zenodo.4917086', dataset.fetch('identifier')
    assert_equal 'https://creativecommons.org/licenses/by/4.0/', dataset.fetch('license')
    assert_equal 5, dataset.fetch('creator').size
    assert_equal 22, dataset.fetch('distribution').size
    assert_equal data.fetch('files').map { |file| file.fetch('url') }, dataset.fetch('distribution').map { |file| file.fetch('contentUrl') }
    dataset.fetch('distribution').each do |file|
      assert doc.at_css("a[href='#{file.fetch('contentUrl')}']"), file.fetch('name')
      refute_equal data.fetch('url'), file.fetch('contentUrl')
    end
    assert_equal '2021', BibTeX.open(File.join(SEO_DESTINATION, 'datasets/mentorship.bib')).entries.values.first[:year].to_s
    assert_equal '2022', meta(document('/publications/mentorship-dataset/'), 'citation_year')
  end

  def test_internal_links_and_fragments_resolve
    paths = sitemap_urls.reject { |url| url.end_with?('.pdf') }.map { |url| URI(url).path }
    failures = []
    paths.each do |path|
      doc = document(path)
      ids = doc.css('[id]').map { |element| element['id'] }
      assert_equal ids.uniq, ids, "Duplicate IDs on #{path}"
      doc.css('a[href]').each do |link|
        raw = link['href']
        next if raw.empty? || raw.match?(/\A(?:mailto:|tel:|javascript:)/)
        url = URI.join(ORIGIN + path, raw)
        next unless url.host == URI(ORIGIN).host
        target = File.join(SEO_DESTINATION, URI::DEFAULT_PARSER.unescape(url.path).delete_prefix('/'))
        target = File.join(target, 'index.html') if File.directory?(target)
        unless File.file?(target)
          failures << "#{path}: missing #{raw}"
          next
        end
        next unless url.fragment && File.extname(target) == '.html'
        target_doc = Nokogiri::HTML(File.read(target))
        fragment = URI::DEFAULT_PARSER.unescape(url.fragment)
        failures << "#{path}: missing fragment #{raw}" unless target_doc.css('[id], a[name]').any? { |element| element['id'] == fragment || element['name'] == fragment }
      rescue URI::InvalidURIError
        failures << "#{path}: invalid URL #{raw}"
      end
    end
    assert_empty failures
  end

  def test_old_internal_deadlines_are_accessible_but_not_indexable
    doc = document('/deadlines')
    assert_equal 'noindex, follow', meta(doc, 'robots')
    refute_includes sitemap_urls, ORIGIN + '/deadlines'
    refute_includes sitemap_urls, ORIGIN + '/images/sos_logo.pdf'
    assert File.file?(File.join(SEO_DESTINATION, 'images/sos_logo.pdf'))
  end

  def test_visible_control_names_are_present_in_accessible_names
    doc = document('/')
    doc.css('.brand, [data-lens]').each do |control|
      next unless control['aria-label']
      visible_name = control.text.gsub(/\s+/, ' ').strip.downcase
      assert_includes control['aria-label'].downcase, visible_name
    end
  end

  def test_production_analytics_uses_only_a_configured_ga4_id
    config = YAML.safe_load(File.read('_config.yml'))
    id = config.fetch('analytics').fetch('google').fetch('tracking_id').to_s
    doc = document('/')
    scripts = doc.css('script[src]').map { |script| script['src'] }
    refute scripts.any? { |src| src.include?('google-analytics.com/ga.js') || src.include?('analytics.js') }
    tags = scripts.select { |src| src.include?('googletagmanager.com/gtag/js') }
    if id.start_with?('G-') && id.size > 4
      assert_equal ["https://www.googletagmanager.com/gtag/js?id=#{id}"], tags
      assert_includes doc.to_html, 'soscdAnalyticsReady'
    else
      assert_empty tags
      refute_includes doc.to_html, 'soscdAnalyticsReady'
    end
  end
end
