require 'yaml'
require 'bibtex'

# Parse the BibTeX file
bib_data = BibTeX.open('./_bibliography/references.bib')

# Extract years and paper IDs
year_paper_map = {}

bib_data.entries.each do |entry|
  entry = entry[1]  # Access the actual entry from the array
  year = entry[:year].to_s || 'unknown'
  paper_id = entry.key

  year_paper_map[year] ||= []
  year_paper_map[year] << paper_id
end

# Generate the script
script = """
<script type=\"text/javascript\">

var waitForLoad = function () {
    if (typeof $ != \"undefined\") {
        $(document).ready(function() {
            var filter = function() {
                var doc_id_value = \"\";
                var map_data = set_year_paper_id_map();
                $(\".bib_entry\").each(function() {
                    var entry_type_article = $(this).hasClass(\"entry_type_article\");
                    var entry_type_conference = $(this).hasClass(\"entry_type_inproceedings\");                    
                    var code_exists = $(this).hasClass(\"code_exists_true\");
                    var demo_exists = $(this).hasClass(\"demo_exists_true\");
                    var dataset_exists = $(this).hasClass(\"dataset_exists_true\");
                    
                    var show_based_on_entry_type = (entry_type_article && $(\"#entry_type_article\").is(\":checked\")) || 
                                                   (entry_type_conference && $(\"#entry_type_conference\").is(\":checked\")) || 
                                                   (dataset_exists && $(\"#entry_type_dataset\").is(\":checked\")) || 
                                                   (code_exists && $(\"#entry_type_code\").is(\":checked\")) || 
                                                   (demo_exists && $(\"#entry_type_demo\").is(\":checked\"));

                    if (show_based_on_entry_type) {
                        $(this).closest('li').show();
                        $.each(this.attributes, function() {
                            if (this.name === \"id\") {
                                doc_id_value = this.value
                            }
                        });
                        for (var year in map_data) {
                            if (map_data.hasOwnProperty(year)) {
                                map_data[year].forEach(function(item) {
                                    if (doc_id_value === item) {
                                        document.getElementById(year).style.display = \"block\";
                                        document.getElementById(year + '-hr').style.display = \"block\";
                                    }
                                });
                            }
                        }
                    } else {
                        $(this).closest('li').hide();
                    }
                });

            };
            set_display_status();
            filter();
            $(\"input\").change(function() {
                set_display_status();
                filter();
            });
        });
    } else {
        setTimeout(waitForLoad, 100);
    }
};

function set_display_status() {
    // For every new header added to represent new year, set the display attribute to \"none\" in this function.
"""

# Add display settings for each year
year_paper_map.each do |year, _|
  if year.to_i > 2015
    script += """
        document.getElementById('#{year}').style.display = \"none\";
        document.getElementById('#{year}-hr').style.display = \"none\";"""
  end
end

script += """
        document.getElementById('2008-2015').style.display = \"none\";
        document.getElementById('2008-2015-hr').style.display = \"none\";"""

script += """
}

function set_year_paper_id_map() {
    // Update the below object with the year and paper id of every new paper added in references.bib
    return  {"""

# Add year-paper_id mappings
initial_papers = ""
year_paper_map.each do |year, paper_ids|
  if year.to_i <= 2015
    paper_ids_str = paper_ids.join('", "')
    initial_papers += paper_ids_str
    initial_papers += '","'
  else
    paper_ids_str = paper_ids.join('", "')
    script += """
            '#{year}': [\"#{paper_ids_str}\"],"""
  end
end

script += """
            '2008-2015': [\"#{initial_papers}\"],"""

script += """
    }
}
waitForLoad();

</script>
"""

sorted_years = year_paper_map.keys.sort.reverse

script += """

<h1  id='2050'> Under Review </h1>
<hr id='2050-hr'>
"""

script += """

{% bibliography --query @*[year>""" + sorted_years[1].to_s + """]%}
"""

sorted_years.each do |year|
  if year.to_i > 2015 && year.to_i != 2050
    script += """
<h1  id='#{year}'> #{year} </h1>
<hr  id='#{year}-hr'>"""
    script += """
{% bibliography --query @*[year=#{year}]%}
"""
  end
end

script += """
<h1  id='2008-2015'> 2008-2015 </h1>
<hr  id='2008-2015-hr'>
{% bibliography --query @*[year<=2015]%}

"""

# Write the script to a markdown file
#markdown_content = File.read('./_pages/publications.md')
#markdown_content += script

# Write back to the file
#File.open('./_pages/publications.md', 'w') do |file|
#  file.write(markdown_content)
#end

file_path = './_pages/publications.md'

# Read the file
content = File.read(file_path)

# Insert the text between the specified lines
new_content = content.gsub(/(<!-- DO NOT REMOVE THIS LINE : BEGIN -->)(.*?)(<!-- DO NOT REMOVE THIS LINE : END -->)/m) do
  "#{$1}\n#{script}#{$3}"
end

# Write the updated content back to the file
File.open(file_path, 'w') { |file| file.write(new_content) }

puts "Markdown file 'publications.md' has been generated."
