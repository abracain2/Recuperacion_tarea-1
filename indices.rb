class Indices
    VERSION = "0.0.1"
  
    require_relative 'spiders'
    require_relative 'normalize'
    
  
    
    norm = Normalize.new()
    #ind = Spiders.new()
  
    #ind.spiders
    norm.normalize_text(File.read("leeme.txt"))
  
end