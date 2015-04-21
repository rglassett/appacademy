class GuessingGame
  attr_reader :current_guess, :guesses, :number

  def initialize
    @current_guess = nil
    @number = rand(1..100)
    @guesses = 0
  end

  def get_guess
    @current_guess = gets.chomp.to_i
    @guesses += 1
  end

  def respond_to_guess
    case current_guess <=> number
    when -1
      puts "Too low!"
    when 0
      puts "Correct! The number was #{number}."
    when 1
      puts "Too high!"
    end
  end

  def run
    puts "I am thinking of a number between 1 and 100. Can you guess the number?"
    until current_guess == number
      get_guess
      respond_to_guess
    end
    puts "You won in #{guesses} tries."
  end
end

if __FILE__ == $PROGRAM_NAME
  GuessingGame.new.run
end
