class Tfidf
    VERSION = "0.0.1"
  
    require 'tf-idf-similarity'
    
  
    def initialize
        
    end
    
    def get_tf_idf(document, term)
        
        tf = document.term_count(term)
        resultado = (tf * 2.2) / (tf + 0.3 + 0.9 * document.size / @model.average_document_size)
        
        return resultado
        
    end
    
end