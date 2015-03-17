class Dictionary
  require 'set'
  DEFAULT_DICTIONARY = 'dictionary.txt'
  
  attr_reader :words
  
  def self.for_length(len)
    Dictionary.new.pare_to_length(len) 
  end
  
  def initialize(filename = DEFAULT_DICTIONARY)
    # print 'Loading dictionary...'
    @words = Set.new(File.readlines(filename).map(&:chomp))
    # puts 'done!'
  end
  
  def pare_to_length(length)
    print 'Paring by length...'
    @words.select! { |word| word.length == length }
    puts 'done!'
    self
  end
  
  def sample
    words.to_a.sample
  end
end

class WordChainer
  def initialize(start_word, end_word)
    @start_word, @end_word = start_word, end_word
    @dictionary = Dictionary.for_length(start_word.length)
  end
  
  def self.random(length = rand(1..6))
    dict = Dictionary.new
    dict.pare_to_length(length)
    start = dict.sample
    target = dict.sample
    puts "Looking for word chain between #{start} and #{target}..."
    WordChainer.new(start, target)
  end
  
  def run
    @all_seen_words = { @start_word => nil }
    @current_words = [@start_word]
    until @current_words.empty? || @all_seen_words.include?(@end_word)
      new_current_words = explore_current_words
      @current_words = new_current_words
    end
    build_path(@end_word)
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
    
    raise "No path to target word!" unless path.include?(@start_word)
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
  
  # def get_regexes(next_word)
  #   regexes = []
  #
  #   next_word.length.times do |i|
  #     regex = next_word.dup
  #     regex[i] = '\w'
  #     regexes << Regexp.new(regex)
  #   end
  #
  #   regexes
  # end
end

if __FILE__ == $PROGRAM_NAME
  # wc = WordChainer.new("duck", "ruby")
  wc = WordChainer.random
  p wc.run
end