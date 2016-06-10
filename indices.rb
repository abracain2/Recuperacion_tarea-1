class Indices
    VERSION = "0.0.1"
  
    require_relative 'packages/spiders'
    require_relative 'packages/normalize'
    require_relative 'packages/tfidf'
    
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
    indice_terminos_contf_idf = Hash.new(0)
    id = 0 #id de la pagina o url que se acaba de visitar
    
    indice_urls[1] = "url de la pagina" # aqui se mete el id y la url de cada pagina analizada
    
    norm = Normalize.new()
    ind = Indices.new()
    tfidf = Tfidf.new()
  
    #spi.spiders
    hash = norm.normalize_text(File.read("texto.txt"))
    
    hash.term_counts.each do |word, count|
        num_tf_idf = tfidf.get_tf_idf(hash, word)
        sub_indices = ind.union_hash(indice_terminos[word], {id=>count})
        indice_terminos[word] = sub_indices
        sub_indices = ind.union_hash(indice_terminos[word], {id=>num_tf_idf})
        indice_terminos_contf_idf[word] = sub_indices
    end
    
    id = 1
    
    hash = norm.normalize_text(File.read("texto2.txt"))
    
    hash.term_counts.each do |word, count|
        num_tf_idf = tfidf.get_tf_idf(hash, word)
        sub_indices = ind.union_hash(indice_terminos[word], {id=>count})
        indice_terminos[word] = sub_indices
        sub_indices = ind.union_hash(indice_terminos[word], {id=>num_tf_idf})
        indice_terminos_contf_idf[word] = sub_indices
    end

    puts indice_terminos
end