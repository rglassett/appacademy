def substrings(word)
  words = []
  
  for i in (0...word.length)
    for j in (i...word.length)
      words << word[i..j]
    end
  end
  
  words
  
end

def subwords(word, dict = "dictionary.txt")
  dict = File.readlines(dict)
  dict.collect! { |word| word.chomp }
  possible_words = substrings(word)
  actual_words = []

  possible_words.each do |possible_word|
    if dict.include?(possible_word)
      actual_words << possible_word
    end
  end
  
  actual_words

end
