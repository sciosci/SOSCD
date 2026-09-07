require 'yaml'
require 'cgi'

news = YAML.safe_load(File.read('./news.yml'))
def event_html(event)
  description = event['description'].gsub(/href="(\/[^"]*)"/) { "href=\"{{ '#{$1}' | relative_url }}\"" }
  "<li class=\"news-item\"><div class=\"news-date\">#{CGI.escapeHTML(event['date'])}</div><div class=\"news-description\">#{description}</div></li>"
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
  #{archive}
PAGE
preview = news.values.flatten.first(4).map { |event| event_html(event) }.join("\n")
File.write('_includes/lab-news-preview.html', "<ul class=\"news-list\">\n#{preview}\n</ul>\n")
puts "Generated news archive and homepage preview from news.yml."
