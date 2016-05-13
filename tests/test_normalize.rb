VERSION = "0.0.1"

require "test/unit"

require_relative "../packages/normalize"

class TestSimpleNumber < Test::Unit::TestCase

    def test_normalize_text
        document = "esta es la historia de un pajaro que volaba, pero se convirtio en gallina, no volaba pero seguia siendo un pajaro al menos"
        assert_kind_of( Hash, Normalize.new().normalize_text(document), "me devuelve el tipo correcto de dato" )
        assert_not_nil( Normalize.new().normalize_text(document), "No me lo devuelve nulo" )
        assert_equal( ["esta"=>1, "historia"=>1, "pajaro"=>2, "volaba"=>2, "convirtio"=>1, "gallina"=>1, "siendo"=>1, "seguia"=>1, "meno"=>1], [Normalize.new().normalize_text(document)] )
    end
    
    def test_normalize
        # falta hacer proceso de datos, buscar mas casos
        assert_equal( 'informacion', Normalize.new().normalize_word('informaciones') )
        assert_equal( 'biblioteca', Normalize.new().normalize_word('bibliotecas') )
        assert_equal( 'semana', Normalize.new().normalize_word('sëmanas') )
        assert_equal( 'semana', Normalize.new().normalize_word('sémanas') )
        assert_equal( 'yiguirro', Normalize.new().normalize_word('yigüirro') )
        assert_match( Normalize.new().normalize_word('bibliotecas'), 'biblioteca' )
    end
    
    def test_top_words
        # falta ver como revizamos los hash para ver si devuelve lo que nosotros queremos
        assert_not_nil( Normalize.new().top_words("Lorem exiliamum pretendus infinitus"), "lo devolvio y no tenia ningun top words" )
        assert_equal( 0, Normalize.new().top_words("en un ser se de a que y").length, "lo devolvio sin top words" )
        assert_equal( 2, Normalize.new().top_words("el ser mas querido").length )
        assert_equal( ["Lorem", "exiliamum", "pretendus", "infinitus"], Normalize.new().top_words("Lorem exiliamum pretendus infinitus") )
        assert_equal( ["final", "mas", "perfecto", "para", "comienzo", "medio", "perdido"], Normalize.new().top_words("el final mas perfecto para un comienzo medio perdido") )
    end
    
    def test_top_words
        # falta ver como revizamos los hash para ver si devuelve lo que nosotros queremos
        assert_not_nil( Normalize.new().top_words("Lorem exiliamum pretendus infinitus"), "lo devolvio y no tenia ningun top words" )
        assert_equal( 0, Normalize.new().top_words("en un ser se de a que y").length, "lo devolvio sin top words" )
        assert_equal( 2, Normalize.new().top_words("el ser mas querido").length )
        assert_equal( ["Lorem", "exiliamum", "pretendus", "infinitus"], Normalize.new().top_words("Lorem exiliamum pretendus infinitus") )
        assert_equal( ["final", "mas", "perfecto", "para", "comienzo", "medio", "perdido"], Normalize.new().top_words("el final mas perfecto para un comienzo medio perdido") )
    end
    
    def test_count_tokens
        # falta ver como revizamos los hash para ver si devuelve lo que nosotros queremos
        assert_equal( 0, Normalize.new().count_tokens(Normalize.new().normalize_text("en un ser se de a que y")) )
        assert_equal( 7, Normalize.new().count_tokens(Normalize.new().normalize_text("el final mas perfecto para un comienzo medio perdido")) )
    end
    
    def test_throw_empty_tokens
        assert_not_nil( Normalize.new().throw_empty_tokens("") )
        assert_equal( true, Normalize.new().throw_empty_tokens("\n") )
        assert_equal( true, Normalize.new().throw_empty_tokens(":") )
        assert_equal( true, Normalize.new().throw_empty_tokens(".") )
        assert_equal( true, Normalize.new().throw_empty_tokens(";") )
        assert_equal( false, Normalize.new().throw_empty_tokens("hola") )
    end
    
end