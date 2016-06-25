class Indices
    VERSION = "0.0.1"
  
    require_relative 'packages/spiders'
    require_relative 'packages/normalize'
    require_relative 'packages/structures'
    
    def hacer_indices(structure)
    
        norm = Normalize.new()
        struct = structure
      
        #spi.spiders
        hash = Hash.new()
        hash = norm.normalize_text(File.read("../texto.txt"))
        
        struct.add_document("texto.txt", hash)
        
        hash = norm.normalize_text(File.read("../texto2.txt"))
        
        struct.add_document("texto2.txt", hash)
        
    
        hash = norm.normalize_text(File.read("../sinRepetidosTitulos.txt"))
        struct.add_document("sinRepetidosTitulos.txt", hash)
    
        return struct
    
    end
end