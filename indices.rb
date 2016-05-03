class Indices
    VERSION = "0.0.1"
  
    load 'spiders.rb'
    load 'normalize.rb'
    
  
    
    norm = Normalize.new()
    ind = Spiders.new()
  
    #ind.spiders
    norm.normalize_text(File.read("leeme.txt"))
  
end