require 'yaml'

# Function to generate HTML content for a year
def generate_html_for_year(year, events)
  html = """
<!-- #{year} News -->
<div style=\"border: 2px solid #333; padding: 15px; margin-bottom: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\">
  <h2 style=\"background-color: #5bc0de; padding: 10px; border-radius: 5px; text-align: center;\">#{year}</h2>
  <ul style=\"list-style: none; padding-left: 0;\">
    """
  
  events.each do |event|
    html += """\
<li style=\"display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;\">
        <div style=\"flex: 1;\">
            #{event['description']}
        </div>
        <div style=\"flex: 0 0 150px; text-align: right; color: #555; font-style: italic;\">
            #{event['date']}
        </div>
    </li>
    """
  end

  html += """
  </ul>
</div>
"""
  html
end

# Read YAML file
news_data = YAML.safe_load(File.read('./news.yml'))

# Generate markdown content
markdown_content = ""
news_data.each do |year, events|
  markdown_content += generate_html_for_year(year, events)
end

final_content = "# News\n" + markdown_content

# Write to markdown file
File.open('_pages/news.md', 'w') do |file|
  file.write(final_content)
end

puts "Markdown file 'news.md' has been generated."
