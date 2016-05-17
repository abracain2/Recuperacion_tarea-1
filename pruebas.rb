require 'spidr'
require 'open-uri'

wiki1 = File.new("body.txt", "w")
wiki2 = File.new("links.txt","w")

Spidr.host('www.ucr.ac.cr') do |spider|
  spider.every_html_page do |page|
      wiki1.puts(page.doc)
      spider.every_url {|url| wiki2.puts(url)}
      end
  end
 
wiki1.close
wiki2.close