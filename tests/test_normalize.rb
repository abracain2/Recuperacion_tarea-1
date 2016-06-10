VERSION = "0.0.1"

require "test/unit"

require_relative "../packages/normalize"

class TestSimpleNumber < Test::Unit::TestCase

    def setup
        
        @norm = Normalize.new()
        
    end
    
    def test_normalize_text
        
        document = "esta es la historia de un pajaro que volaba, pero se convirtio en gallina, no volaba pero seguia siendo un pajaro al menos"
        assert_kind_of( TfIdfSimilarity::Document, @norm.normalize_text(document), "me devuelve el tipo correcto de dato" )
        assert_not_nil( @norm.normalize_text(document), "No me lo devuelve nulo" )
        assert_equal( ["esta"=>1, "historia"=>1, "pajaro"=>2, "volaba"=>2, "convirtio"=>1, "gallina"=>1, "siendo"=>1, "seguia"=>1, "meno"=>1], [(@norm.normalize_text(document)).term_counts] )
        
    end
    
    def test_normalize
        
        # falta hacer proceso de datos, buscar mas casos
        assert_equal( 'informacion', @norm.normalize_word('informaciones') )
        assert_equal( 'biblioteca', @norm.normalize_word('bibliotecas') )
        assert_equal( 'semana', @norm.normalize_word('sëmanas') )
        assert_equal( 'semana', @norm.normalize_word('sémanas') )
        assert_equal( 'yiguirro', @norm.normalize_word('yigüirro') )
        assert_match( @norm.normalize_word('bibliotecas'), 'biblioteca' )
        
    end
    
    def test_top_words
        
        # falta ver como revizamos los hash para ver si devuelve lo que nosotros queremos
        assert_not_nil( @norm.top_words("Lorem exiliamum pretendus infinitus"), "lo devolvio y no tenia ningun top words" )
        assert_equal( 0, @norm.top_words("en un ser se de a que y").length, "lo devolvio sin top words" )
        assert_equal( 2, @norm.top_words("el ser mas querido").length )
        assert_equal( ["Lorem", "exiliamum", "pretendus", "infinitus"], @norm.top_words("Lorem exiliamum pretendus infinitus") )
        assert_equal( ["final", "mas", "perfecto", "para", "comienzo", "medio", "perdido"], @norm.top_words("el final mas perfecto para un comienzo medio perdido") )
        
    end
    
    def test_top_words
        
        # falta ver como revizamos los hash para ver si devuelve lo que nosotros queremos
        assert_not_nil( @norm.top_words("Lorem exiliamum pretendus infinitus"), "lo devolvio y no tenia ningun top words" )
        assert_equal( 0, @norm.top_words("en un ser se de a que y").length, "lo devolvio sin top words" )
        assert_equal( 2, @norm.top_words("el ser mas querido").length )
        assert_equal( ["Lorem", "exiliamum", "pretendus", "infinitus"], @norm.top_words("Lorem exiliamum pretendus infinitus") )
        assert_equal( ["final", "mas", "perfecto", "para", "comienzo", "medio", "perdido"], @norm.top_words("el final mas perfecto para un comienzo medio perdido") )
        
    end
    
    def test_count_tokens
        
        # falta ver como revizamos los hash para ver si devuelve lo que nosotros queremos
        assert_equal( 0, @norm.count_tokens((@norm.normalize_text("en un ser se de a que y")).term_counts) )
        assert_equal( 7, @norm.count_tokens((@norm.normalize_text("el final mas perfecto para un comienzo medio perdido")).term_counts) )
        
    end
    
    def test_throw_empty_tokens
        
        assert_not_nil( @norm.throw_empty_tokens("") )
        assert_equal( true, @norm.throw_empty_tokens("\n") )
        assert_equal( true, @norm.throw_empty_tokens(":") )
        assert_equal( true, @norm.throw_empty_tokens(".") )
        assert_equal( true, @norm.throw_empty_tokens(";") )
        assert_equal( false, @norm.throw_empty_tokens("hola") )
        
    end
    
end