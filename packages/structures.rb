class Structures
    VERSION = "0.0.1"
    
    require_relative 'tfidf'

    @@indice_urls = Hash.new(0)
    @@indice_documents = Hash.new(0)
    @@indice_terminos = Hash.new(0)
    @@indice_terminos_contf_idf = Hash.new(0)
    @@id = 0
    @@tfidf = Tfidf.new()

    def initialize
    end
    
    def add_document(url, document)
        
        @@indice_urls[@@id] = url
        @@indice_documents[@@id] = document
        
        sub_indices = Hash.new(0)
        
        document.term_counts.each do |word, count|
            num_tf_idf = @@tfidf.get_tf_idf(document, word)
            sub_indices = union_hash(@@indice_terminos[word], {@@id=>num_tf_idf})
            @@indice_terminos_contf_idf[word] = sub_indices
            
            sub_indices = union_hash(@@indice_terminos[word], {@@id=>count})
            @@indice_terminos[word] = sub_indices
        end
        
        @@id += 1
        
    end
    
    def get_documents_from_term(term)
        
        resultado = Array.new
        
        @@indice_terminos.each do |word, documents|
            
            if term == word
                
                documents.each do |id, count|
                    resultado.push(id)
                end
            end
        end
        
        return resultado
        
    end
    
    def term_count_in_documents(term)
        
        resultado = Hash.new(0)
        
        @@indice_terminos.each do |word, documents|
            if term == word
                
                resultado = documents
                
                break
            end
        end
        
        return resultado
        
    end
    
    def term_tf_idf_in_documents(term)
        
        resultado = Hash.new(0)
        
        @@indice_terminos_contf_idf.each do |word, tf_ids_documents|
            if term == word
                
                resultado = tf_ids_documents
                
                break
            end
        end
        
        return resultado
        
    end
    
    def get_document(id)
        
        return @@indice_documents[id]
        
    end
    
    def get_id_document(document)
        
        resultado = -1
        
        @@indice_documents.each do |id, documentx|
            if documentx == document
                resultado = id
                break
            end
        end
        
        return resultado
        
    end
    
    def get_url(id)
        
        return @@indice_urls[id]
        
    end
    
    def get_id_url(url)
        
        resultado = -1
        
        @@indice_urls.each do |id, urlx|
            if urlx == url
                resultado = id
                break
            end
        end
        
        return resultado
        
    end
    
    def get_all_terms_counts()
        
        return @@indice_terminos
        
    end
    
    def get_all_terms_tf_idf()
        
        return @@indice_terminos_contf_idf
        
    end
    
    def union_hash(hash1, hash2)
        
        resultado = Hash.new(0)
        
        if hash1 != 0
            hash1.each do |id, count|
                resultado[id] = count
            end
        end
        if hash2 != 0
            hash2.each do |id, count|
                resultado[id] = count
            end
        end
        
        return resultado
        
    end
    
    def union_avg_hash(hash1, hash2)
        
        resultado = Hash.new(0)
        
        if hash1 != 0
            hash1.each do |id, tf_idf|
                resultado[id] += tf_idf
            end
        end
        if hash2 != 0
            hash2.each do |id, tf_idf|
                resultado[id] += tf_idf
            end
        end
        
        return resultado
        
    end
end