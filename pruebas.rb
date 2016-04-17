require 'spidr'

# Prueba de que la gema funciona
Spidr.site('http://spidr.rubyforge.org/') do |spider|
  spider.every_html_page do |page|
    puts page.title
  end
end