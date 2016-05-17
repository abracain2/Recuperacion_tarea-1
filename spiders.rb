class Spiders
    VERSION = "0.0.1"
    require 'spidr'
  
    def initialize
        
    end
    
    def spiders
        Spidr.site('www.ucr.ac.cr') do |spider|
            spider.every_html_page do |page|
                puts page.doc
            end
        end
    end
end