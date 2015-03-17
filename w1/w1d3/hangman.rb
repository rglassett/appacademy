# Phase 1: human guesses word
## Computer reads in a dictionary file and chooses a word randomly.
### Game instance variables: dictionary_file, secret_word

# Phase 2: computer guesses letters randomly

class HumanPlayer
  attr_reader :name
  attr_accessor :guesses, :secret_length, :secret_progress
  
  def initialize(name = "Qui-Gon Jinn")
    @name = name
    @guesses = []
    @secret_length = 0
    @secret_progress = []
  end
  
  def pick_secret_word
    puts "Enter the length of your word: "
    secret_length = gets.chomp.to_i
    secret_progress = Array.new(secret_length, "_")
  end
  
  def receive_secret_length(length)
    secret_length = length
  end
  
  def guess
    while true
      puts "Previous guesses: #{@guesses.to_s}"
      print "Guess a letter: "
      letter = gets.chomp.downcase
      if letter.length != 1
        puts "Guess must be a string of length one."
      else
        guesses << letter
        break
      end
    end
    letter
  end
  
  def check_guess(computer_guess)
    puts "The computer guessed the letter #{computer_guess}."
    puts "Please enter a list of the indices where this letter appears, or leave the response empty."
    response = gets.chomp
    unless response == ""
      response.split(", ").map(&:to_i).each do |index|
        secret_progress[index] = computer_guess
      end
    end
  end
  
end

class ComputerPlayer
  attr_reader :secret_word, :name, :guesses
  attr_accessor :secret_length, :secret_progress
  
  def initialize(dictionary_filename = "dictionary.txt", name = "Compy 5000")
    @dictionary = File.readlines(dictionary_filename).map(&:chomp)
    @name = name
    @secret_word = nil
    @secret_length = 0
    @secret_progress = []
    @guesses = []
    
  end
  
  def pick_secret_word
    @secret_word = @dictionary.sample
    @secret_length = @secret_word.length
    @secret_progress = Array.new(@secret_word.length, "_")
  end
  
  def receive_secret_length(length)
    @secret_length = length
    @dictionary = @dictionary.select {|word| word.length == length}
  end
  
  def guess # come back to fix redundancy
    regex_pare_dictionary
    letter = get_highest_freq_letter
    @guesses << letter
    letter
  end
  
  def check_guess(players_guess)
    @secret_word.length.times do |index|
      if @secret_word[index] == players_guess
        @secret_progress[index] = players_guess
      end
    end
  end
  
  # def pare_dictionary
  #   temp_dict = @dictionary.dup
  #   @dictionary.each do |word|
  #     @secret_progress.each_index do |i|
  #       if @secret_progress[i] != '_' && @secret_progress[i] != word[i]
  #         temp_dict.delete(word)
  #       end
  #     end
  #   end
  #   @dictionary = temp_dict
  # end
  
  def regex_pare_dictionary
    temp_dict = @dictionary.dup
    regex = Regexp.new @secret_progress.join.gsub('_','\w')
    @dictionary = temp_dict.select { |word| regex.match(word) }
  end
  
  def get_highest_freq_letter
    frequencies = {}
    string_of_letters = @dictionary.join
    options = ('a'..'z').to_a.reject { |ltr| @guesses.include?(ltr) }
    options.each do |letter|
      frequencies[letter] = string_of_letters.count(letter)
    end
    frequencies.max_by{|k, v| v}[0]
  end
end

class HangmanGame
  attr_reader :guessing_player, :checking_player
  
  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
  end
  
  def play
    checking_player.pick_secret_word
    
    until won?
      transmit_secret_length
      display
      checking_player.check_guess(guessing_player.guess)
      sync_progress
    end
    puts "The word was #{checking_player.secret_progress.join}."
    puts "#{guessing_player.name} won in #{guessing_player.guesses.length} guesses!"
  end
  
  def transmit_secret_length
    guessing_player.receive_secret_length(checking_player.secret_length)
  end
  
  def display
    puts "Secret word: " + checking_player.secret_progress.join
  end
  
  def won?
    !checking_player.secret_progress.include?("_")
  end
  
  def sync_progress
    guessing_player.secret_progress = checking_player.secret_progress
  end
  
end

if __FILE__ == $PROGRAM_NAME
  guessing_player = ComputerPlayer.new
  checking_player = ComputerPlayer.new

  game = HangmanGame.new(guessing_player, checking_player)
  game.play
end