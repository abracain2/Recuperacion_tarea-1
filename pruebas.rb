require 'spidr'

out_file = File.new("out.txt", "w")

# Prueba de que la gema funciona.
Spidr.host('www.ucr.ac.cr') do |spider|
  spider.every_html_page do |page|
    out_file.puts(page.body)
  end
end
out_file.close