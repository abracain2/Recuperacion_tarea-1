class Normalize
    VERSION = "0.0.1"
  
    require 'matrix'
    require 'tf-idf-similarity'
    require 'unicode_utils'
    require 'active_support/inflector'
    
  
    def initialize
        
    end
    
    def normalize_text(document)
        
        
        
        # se guarda los tokens sin los top words
        tokens_without_topwords = UnicodeUtils.each_word(document).to_a - ['la', 'el', 'ella', 'con', 'los', 'las']
        
        # inicializacion de variables, se guarda los terminos y la cantidad de terminos encontrados
        terms = Hash.new(0)
        size = 0
        
        tokens_without_topwords.each do |token|
            unless token[/\A\d+\z/]
                
                term = token
                
                # quita todos los acentos
                term = ActiveSupport::Inflector.transliterate(term)
                
                # este hace que los tokens se hagan en singular
                term = ActiveSupport::Inflector.singularize(term)  
                
                # pone todas las letras en minuscula
                term = ActiveSupport::Inflector.underscore(term) 
                
                # Elimina los signos de puntuacion
                terms[term.gsub(/\p{Punct}/, '')] += 1
                size += 1
                
            end
            
        end
        
        new_document = TfIdfSimilarity::Document.new(document, :terms => terms, :size => size)
        
        puts :terms => terms
        
    end
    
end