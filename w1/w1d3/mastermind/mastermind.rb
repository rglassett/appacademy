class Code
  attr_reader :sequence

  COLORS = %w(R G B Y O P)

  def self.random
    sequence = []
    4.times { sequence << COLORS.sample }
    self.new(sequence)
  end

  def self.valid?(sequence)
    sequence.length == 4 && sequence.all? { |el| COLORS.include?(el) }
  end

  def initialize(sequence = [])
    @sequence = sequence
  end

  def [](i)
    sequence[i]
  end

  def count(el)
    sequence.count(el)
  end

  def exact_matches(other_code)
    counter = 0
    sequence.each_index do |i|
      counter += 1 if self[i] == other_code[i]
    end
    counter
  end

  def near_matches(other_code)
    counter = 0
    other_code.sequence.uniq.each do |el|
      counter += [self.count(el), other_code.count(el)].min
    end
    counter - exact_matches(other_code)
  end

  def ==(other_code)
    return false unless other_code.is_a?(self.class)
    self.sequence == other_code.sequence
  end
end


class Game
  attr_reader :code

  def initialize(turns = 10)
    @turns = turns
    @code = Code.random
  end

  def get_code
    sequence = []
    until Code.valid?(sequence)
      puts "Enter your guess (4 letters, no spaces):"
      puts "Valid colors are #{Code::COLORS}"
      sequence = gets.chomp.upcase.split(//)
    end
    Code.new(sequence)
  end

  def feedback(guess)
    puts "You got #{@code.exact_matches(guess)} guesses exactly right (black ball)."
    puts "You got #{@code.near_matches(guess)} almost right (white ball)."
  end

  def play
    until @turns == 0 || @code == @guess
      puts "Turns remaining: #{@turns}"
      @guess = get_code
      feedback(@guess)
      @turns -= 1
    end

    if @code == @guess
      puts "Congratulations, you win!"
    else
      puts "Sorry, maybe next time."
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
