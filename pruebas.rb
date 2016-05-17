#Codigo para el experimento 1
require 'spidr'
require 'open-uri'

#Se crean dos documentos 
#En wiki1 se guardan todos los títulos de las páginas
wiki1 = File.new("title.txt", "w")
#En wiki2 se almacena la dirección url
wiki2 = File.new("links.txt","w")

#Se declara la añara para que corra en el sitio web www.ucr.ac.cr
Spidr.host('www.ucr.ac.cr') do |spider|
  spider.every_html_page do |page|
      wiki1.puts(page.title)
      spider.every_url {|url| wiki2.puts(url)}
      end
  end
 
#Se cierran los archivos de manera correcta
wiki1.close
wiki2.close