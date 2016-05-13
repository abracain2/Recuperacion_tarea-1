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
        terms = Hash.new(0)
        size = 0
        
        tokens_without_topwords.each do |token|
            unless token[/\A\d+\z/]
                
                term = token
                
                term = normalize_word(term)
                
                # Elimina los signos de puntuacion
                terms[term.gsub(/\p{Punct}/, '')] += 1
                size += 1
                
            end
            
        end
        
        new_document = TfIdfSimilarity::Document.new(document, :terms => terms, :size => size)
        
        puts :terms => terms
        
        return terms
        
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
        
        top_words = ['en', 'un', 'ser', 'se', 'de', 'a', 'que', 'y', 'lo', 'la', 'el', 'ella', 'con', 'los', 'las', ' ']
        
        # se guarda los tokens sin los top words
        tokens_without_topwords = UnicodeUtils.each_word(document).to_a - top_words
        
        return tokens_without_topwords
        
    end
    
end