require "test/unit"

require_relative "../packages/normalize"

class TestSimpleNumber < Test::Unit::TestCase

  def test_normalize_text
    
  end

  def test_normalize
    assert_equal( 'informacion', Normalize.normalize_word('informaciones') )
    assert_equal( 'biblioteca', Normalize.normalize_word('bibliotecas') )
    assert_equal( 'semana', Normalize.normalize_word('sëmanas') )
    assert_equal( 'semana', Normalize.normalize_word('sémanas') )
    assert_equal( 'yiguirro', Normalize.normalize_word('yigüirro') )
    assert_match( Normalize.normalize_word('bibliotecas'), 'biblioteca' )
  end

  def test_top_words
    assert_not_nil( Normalize.top_words("Lorem exiliamum pretendus infinitus"), "lo devolvio y no tenia ningun top words" )
    assert_nil( Normalize.top_words("en un ser se de a que y"), "lo devolvio sin top words" )
  end

end