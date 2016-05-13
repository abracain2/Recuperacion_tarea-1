require "test/unit"

require_relative "../packages/normalize"

class TestSimpleNumber < Test::Unit::TestCase

  def test_normalize_text
    document = "esta es la historia de un pajaro que volaba, pero se convirtio en gallina, no volaba pero seguia siendo un pajaro al menos"
    assert_kind_of( Hash, Normalize.new().normalize_text(document), "me devuelve el tipo correcto de dato" )
    assert_not_nil( Normalize.new().normalize_text(document), "No me lo devuelve nulo" )
  end

  def test_normalize
    assert_equal( 'informacion', Normalize.new().normalize_word('informaciones') )
    assert_equal( 'biblioteca', Normalize.new().normalize_word('bibliotecas') )
    assert_equal( 'semana', Normalize.new().normalize_word('sëmanas') )
    assert_equal( 'semana', Normalize.new().normalize_word('sémanas') )
    assert_equal( 'yiguirro', Normalize.new().normalize_word('yigüirro') )
    assert_match( Normalize.new().normalize_word('bibliotecas'), 'biblioteca' )
  end

  def test_top_words
    assert_not_nil( Normalize.new().top_words("Lorem exiliamum pretendus infinitus"), "lo devolvio y no tenia ningun top words" )
    assert_equal( 0, Normalize.new().top_words("en un ser se de a que y").length, "lo devolvio sin top words" )
    assert_equal( 2, Normalize.new().top_words("el ser mas querido").length )
  end

end