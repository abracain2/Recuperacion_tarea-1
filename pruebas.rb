require 'matrix'
require 'tf-idf-similarity'
require 'unicode_utils'

text = "Lorem ipsum dolor sit amet..."
tokens = UnicodeUtils.each_word(text).to_a - ['and', 'the', 'to']
term_counts = Hash.new(0)
size = 0
tokens.each do |token|
  # Unless the token is numeric.
  unless token[/\A\d+\z/]
    # Remove all punctuation from tokens.
    term_counts[token.gsub(/\p{Punct}/, '')] += 1
    size += 1
  end
end
document1 = TfIdfSimilarity::Document.new(text, :term_counts => term_counts, :size => size)

puts :term_counts => term_counts