class Indices
    VERSION = "0.0.1"
  
    require_relative 'packages/spiders'
    require_relative 'packages/normalize'
    require_relative 'packages/structures'
    
    
    norm = Normalize.new()
    struct = Structures.new()
  
    #spi.spiders
    hash = norm.normalize_text(File.read("texto.txt"))
    
    struct.add_document("texto.txt", hash)
    
    hash = norm.normalize_text(File.read("texto2.txt"))
    
    struct.add_document("texto2.txt", hash)
    

    puts struct.get_all_terms_counts()
    puts struct.get_all_terms_tf_idf()
    
    puts struct.get_id_url(struct.get_url(0))
end