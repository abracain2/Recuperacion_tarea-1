class Indices
    VERSION = "0.0.1"
  
    require_relative 'packages/spiders'
    require_relative 'packages/normalize'
    
    def union_hash(hash1, hash2)
        
        resultado = Hash.new(0)
        
        if hash1 != 0
            hash1.each do |id, count|
                resultado[id] = count
            end
        end
        hash2.each do |id, count|
            resultado[id] = count
        end
        
        return resultado
        
    end
    
    indice_urls = Hash.new(0)
    indice_terminos = Hash.new(0)
    id = 0 #id de la pagina o url que se acaba de visitar
    
    indice_urls[1] = "url de la pagina" # aqui se mete el id y la url de cada pagina analizada
    
    norm = Normalize.new()
    ind = Indices.new()
    #spi = Spiders.new()
  
    #spi.spiders
    hash = norm.normalize_text(File.read("sinRepetidosTitulos.txt"))
    hash.each do |word, count|
        sub_indices = ind.union_hash(indice_terminos[word], {id=>count})
        indice_terminos[word] = sub_indices
    end

    puts indice_terminos
end