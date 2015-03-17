class Code
  attr_reader :colors
  attr_accessor :user_guess, :sequence
  
  def initialize
    @sequence = []
    @colors = ["R", "G", "B", "Y", "O", "P"]
    @user_guess = []
  end
  
  def randomize
    self.sequence = []
    4.times do
      self.sequence << colors.sample
    end
  end
  
  def feedback
    puts "You got #{exact_matches} guesses exactly right (black ball)."
    puts "You got #{near_matches} almost right (white ball)."
  end
  
  def exact_matches
    0.tap do |counter|
      @user_guess.each_index do |el|
        counter += 1 if @user_guess[el] == sequence[el]
      end
    end
  end
  
  def near_matches
    counter = 0
    @user_guess.uniq.each do |el|
      upper_bound = sequence.count(el)
      color_count = @user_guess.count(el)
      counter += [color_count, upper_bound].sort[0]
    end
    counter - exact_matches
  end
  
  def won?
    exact_matches == 4
  end
end


class Game
  attr_accessor :turns
  attr_reader :code
  
  def initialize
    @turns = 10
    @code = Code.new
    @code.randomize
  end
  
  def get_input
    while true
      puts "Enter your guess (4 letters):"
      user_input = gets.chomp.upcase.split(//)
      if user_input.length != 4 ||
        user_input.any? { |color| !@code.colors.include?(color)}
        puts "Invalid guess."
      else
        @code.user_guess = user_input
        break
      end
    end
  end
  
  def print_output
    @code.feedback
  end
  
  def play
    until @turns == 0 || @code.won?
      puts "Turns remaining: #{turns}"
      get_input
      print_output
      @turns -= 1
    end
    if @code.won?
      puts "Congratulations, you win!"
    else
      puts "Sorry, maybe next time."
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end