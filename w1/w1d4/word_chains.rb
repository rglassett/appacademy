class Dictionary
  require 'set'
  DEFAULT_DICTIONARY = 'dictionary.txt'
  
  attr_reader :words
  
  def self.for_length(len)
    Dictionary.new.pare_to_length(len) 
  end
  
  def initialize(filename = DEFAULT_DICTIONARY)
    print 'Loading dictionary...'
    @words = Set.new(File.readlines(filename).map(&:chomp))
    puts 'done!'
  end
  
  def pare_to_length(length)
    print 'Paring by length...'
    @words.select! { |word| word.length == length }
    puts 'done!'
    self
  end
end

class WordChainer
  def initialize(start_word, end_word)
    @start_word, @end_word = start_word, end_word
    @dictionary = Dictionary.for_length(start_word.length)
  end
  
  def run(source, target)
    @all_seen_words = { source => nil }
    @current_words = [source]
    until @current_words.empty? || @all_seen_words.include?(target)
      new_current_words = explore_current_words
      @current_words = new_current_words
    end
    build_path(target)
  end
  
  def explore_current_words
    new_current_words = []
    @current_words.each do |word|
      adjacent_words(word).each do |adj_word|
        unless @all_seen_words.include?(adj_word)
          new_current_words << adj_word 
          @all_seen_words[adj_word] = word
        end
      end
    end
    new_current_words
  end
  
  def build_path(target)
    path = [target]
    next_word = target

    until @all_seen_words[next_word].nil?
      next_word = @all_seen_words[next_word]
      path << next_word
    end
  
    path
  end
  
  def adjacent_words(next_word)
    regexes = get_regexes(next_word)
    
    words = @dictionary.words.select do |word| 
      regexes.any? do |regex|
        regex.match(word)
      end
    end
  end
  
  def get_regexes(next_word)
    regexes = []
    
    next_word.length.times do |i|
      unless next_word[i] == @end_word[i]
        regex = next_word.dup
        regex[i] = '\w'
        regexes << Regexp.new(regex)
      end
    end
    
    regexes
  end
end

if __FILE__ == $PROGRAM_NAME
  wc = WordChainer.new("duck", "ruby")
  p wc.run("duck", "ruby")
end