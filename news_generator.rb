require 'yaml'
require 'cgi'
require 'digest'
require 'date'

news = YAML.safe_load(File.read('./news.yml'))
added_metadata = false
news.each do |year, events|
  events.each do |event|
    unless event['id'] && event['updated_at']
      event['id'] ||= Digest::SHA256.hexdigest([year, event['date'], event['description']].join('|'))[0, 16]
      event['updated_at'] ||= DateTime.now.iso8601
      added_metadata = true
    end
  end
end
File.write('news.yml', news.to_yaml) if added_metadata
File.write('_data/news_feed.yml', news.values.flatten.to_yaml)
def event_html(event)
  description = event['description'].gsub(/href="(\/[^"]*)"/) { "href=\"{{ '#{$1}' | relative_url }}\"" }
  "<li class=\"news-item\" id=\"event-#{event['id']}\"><div class=\"news-date\">#{CGI.escapeHTML(event['date'])}</div><div class=\"news-description\">#{description}</div></li>"
end
archive = news.map do |year, events|
  "<section class=\"news-year\" aria-labelledby=\"news-#{year}\"><h2 id=\"news-#{year}\">#{year}</h2><ul class=\"news-list\">\n#{events.map { |event| event_html(event) }.join("\n")}\n</ul></section>"
end.join("\n")
File.write('_pages/news.md', <<~PAGE)
  ---
  layout: single
  title: "News & events"
  permalink: /news/
  description: "Publications, conversations, and milestones from the lab."
  toc: true
  ---
  <p><a href="{{ '/feed.xml' | relative_url }}">Subscribe to lab news</a> · <a href="{{ '/publications/feed.xml' | relative_url }}">Publication feed</a></p>
  #{archive}
PAGE
preview = news.values.flatten.first(4).map { |event| event_html(event) }.join("\n")
File.write('_includes/lab-news-preview.html', "<ul class=\"news-list\">\n#{preview}\n</ul>\n")
puts "Generated news archive and homepage preview from news.yml."
