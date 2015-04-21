class RockPaperScissors
  attr_reader :player1, :player2

  def self.wins
    [
      ["Paper", "Rock"],
      ["Rock", "Scissors"],
      ["Scissors", "Paper"]
    ]
  end

  def self.losses
    wins.map { |combo| combo.reverse }
  end

  def initialize(player1 = ComputerPlayer.new, player2 = ComputerPlayer.new)
    @player1 = player1
    @player2 = player2
  end

  def print_outcome(moves)
    puts "#{moves.first} <=> #{moves.last}"

    if self.class.wins.include?(moves)
      puts "Player 1 wins!"
    elsif moves.first == moves.last
      puts "It's a draw!"
    else
      puts "Player 1 loses!"
    end
  end

  def run
    moves = [player1.make_move, player2.make_move]
    print_outcome(moves)
  end
end

class HumanPlayer
  def self.moves
    {
      "p" => "Paper",
      "r" => "Rock",
      "s" => "Scissors"
    }
  end

  def make_move
    begin
      puts "Enter a move: (r)ock, (p)aper, or (s)cissors"
      input = gets.chomp
      if self.class.moves.has_key?(input)
        self.class.moves[input]
      else
        raise RPSMoveError
      end
    rescue RPSMoveError
      puts "#{input} is not a valid move!"
      retry
    end
  end
end

class ComputerPlayer
  def self.moves
    %w(Rock Paper Scissors)
  end

  def make_move
    self.class.moves.sample
  end
end

class RPSMoveError < StandardError; end

def remix(cocktails)
  alcohols, mixers = cocktails.map(&:first), cocktails.map(&:last)
  new_cocktails = cocktails
  until new_cocktails.none? { |cocktail| cocktails.include?(cocktail) }
    new_cocktails = alcohols.shuffle.zip(mixers)
  end
  new_cocktails
end

if __FILE__ == $PROGRAM_NAME
  p remix([
    ["rum", "coke"],
    ["gin", "tonic"],
    ["scotch", "soda"],
    ["vodka", "ginger ale"]
  ])
end
