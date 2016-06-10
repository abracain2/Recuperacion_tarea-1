class Normalize
    VERSION = "0.0.1"
  
    require 'matrix'
    require 'tf-idf-similarity'
    require 'unicode_utils'
    require 'active_support/inflector'
    require 'inflections'
    
  
    def initialize
        
    end
    
    def normalize_text(document)
        
        # se guarda los tokens sin los top words
        tokens_without_topwords = top_words(document)
        
        # inicializacion de variables, se guarda los terminos y la cantidad de terminos encontrados
        term_counts = Hash.new(0)
        size = 0
        
        tokens_without_topwords.each do |token|
            unless token[/\A\d+\z/]
                
                term = token
                
                term = normalize_word(term)
                
                unless throw_empty_tokens(term)
                
                    # Elimina los signos de puntuacion
                    term_counts[term.gsub(/\p{Punct}/, '')] += 1
                    size += 1
                    
                end
                
            end
            
        end
        
        # hay que revizar de que forma vamos a devolver los resultados o donde lo guardamos
        new_document = TfIdfSimilarity::Document.new(document, :term_counts => term_counts, :size => size)
        
        return new_document
        
    end
    
    def normalize_word(word)
        
        # quita todos los acentos
        word = ActiveSupport::Inflector.transliterate(word)
        
        # este hace que los tokens se hagan en singular
        word = ActiveSupport::Inflector.singularize(word, :es)  
        
        # pone todas las letras en minuscula
        word = ActiveSupport::Inflector.underscore(word) 
        
        return word
        
    end
    
    def top_words(document)
        
        top_words = ['al', 'no', 'pero', 'en', 'un', 'ser', 'se', 'de', 'a', 'que', 'y', 'lo', 'la', 'el', 'ella', 'con', 'los', 'las', ' ']
        
        # se guarda los tokens sin los top words
        tokens_without_topwords = UnicodeUtils.each_word(document).to_a - top_words
        
        return tokens_without_topwords
        
    end
    
    def count_tokens(tokens)
        
        return tokens.length
        
    end
    
    def throw_empty_tokens(token)
        
        flag = false
        
        # elimina los posibles espacios vacios que se agregan en la lista
        if token == "\n" or token == "" or token.gsub(/\p{Punct}/, '') == ""
            flag = true
        end
        
        return flag
        
    end
    
end