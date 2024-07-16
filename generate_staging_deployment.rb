def add_prefix_to_image_in_bib(bib_filename, prefix)
    lines = File.readlines(bib_filename)
    
    image_pattern = /^\s*image\s*=\s*{([^}]+)}\s*,?$/
  
    new_lines = lines.map do |line|
      if match = line.match(image_pattern)
        new_image_value = "#{prefix}#{match[1]}"
        line.sub(match[1], new_image_value)
      else
        line
      end
    end
  
    File.open(bib_filename, 'w') do |file|
      file.puts(new_lines)
    end
  end
  
  def add_prefix_to_image_in_md(md_filename, prefix)
    lines = File.readlines(md_filename)
    
    image_pattern = /image=['"]([^'"]+)['"]/
  
    new_lines = lines.map do |line|
      if match = line.match(image_pattern)
        new_image_value = "#{prefix}#{match[1]}"
        line.sub(match[1], new_image_value)
      else
        line
      end
    end
  
    File.open(md_filename, 'w') do |file|
      file.puts(new_lines)
    end
  end
  
  def remove_prefix_from_image_in_bib(bib_filename, prefix)
    lines = File.readlines(bib_filename)
    
    image_pattern = /^\s*image\s*=\s*{#{Regexp.escape(prefix)}([^}]+)}\s*,?$/
  
    new_lines = lines.map do |line|
      if match = line.match(image_pattern)
        new_image_value = match[1]
        line.sub("#{prefix}#{new_image_value}", new_image_value)
      else
        line
      end
    end
  
    File.open(bib_filename, 'w') do |file|
      file.puts(new_lines)
    end
  end
  
  def remove_prefix_from_image_in_md(md_filename, prefix)
    lines = File.readlines(md_filename)
    
    image_pattern = /image=['"]#{Regexp.escape(prefix)}([^'"]+)['"]/
  
    new_lines = lines.map do |line|
      if match = line.match(image_pattern)
        new_image_value = match[1]
        line.sub("#{prefix}#{new_image_value}", new_image_value)
      else
        line
      end
    end
  
    File.open(md_filename, 'w') do |file|
      file.puts(new_lines)
    end
  end
  
  def update_baseurl_in_config(config_filename, action, prefix)
    lines = File.readlines(config_filename)
    baseurl_pattern = /^(\s*baseurl\s*:\s*)(".+"|'.+'|\S*)\s*$/
  
    new_lines = lines.map do |line|
      if match = line.match(baseurl_pattern)
        if action == 'staging'
          line = "#{match[1]}\"#{prefix}\"\n"
        elsif action == 'live'
          line = "#{match[1]}\"\"\n"
        end
      end
      line
    end
  
    File.open(config_filename, 'w') do |file|
      file.puts(new_lines)
    end
  end
  
  def main(action, bib_filename, md_filename, config_filename, prefix)
    if action == 'staging'
      add_prefix_to_image_in_bib(bib_filename, prefix)
      add_prefix_to_image_in_md(md_filename, prefix)
      update_baseurl_in_config(config_filename, action, prefix)
    elsif action == 'live'
      remove_prefix_from_image_in_bib(bib_filename, prefix)
      remove_prefix_from_image_in_md(md_filename, prefix)
      update_baseurl_in_config(config_filename, action, prefix)
    else
      puts "Invalid action. Use 'staging' or 'live'."
    end
  end
  
  # Usage: ruby modify_images.rb [add|remove] [prefix]
  if ARGV.length != 2
    puts "Usage: ruby modify_images.rb [deploy|live] [prefix]"
  else
    action = ARGV[0]
    bib_filename = "_bibliography/references.bib"
    md_filename = "_pages/people.md"
    config_filename = "_config.yml"
    prefix = ARGV[1]
    main(action, bib_filename, md_filename, config_filename, prefix)
  end
  