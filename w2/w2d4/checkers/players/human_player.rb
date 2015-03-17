class HumanPlayer
  attr_reader :name
  attr_accessor :color
  
  def initialize(name)
    @name = name
  end
  
  def request_handler(game, input)
    case input
    when "save"
      game.save
    when "quit"
      game.quit
    when "load"
      game.load
    when "help"
      game.help
    end
  end
  
  def get_moves(game)
    begin
      print "> "
      input = gets.chomp.downcase
      request_handler(game, input)
      move_seq = parse_seq(input.split)
      
    rescue InvalidMoveError
      retry
    end
    
    move_seq
  end
  
  def parse_seq(move_seq)
    moving_piece = parse_move(move_seq.shift)
    move_seq.map! { |move| parse_move(move) }
    
    [moving_piece, move_seq]
  end
  
  def parse_move(move)
    alphas = ("a".."j").to_a
    unless /^[a-j][0-9]$/.match(move)
      raise InvalidMoveError.new("Cannot understand input!")
    end
    [move[1].to_i, alphas.index(move[0])]
  end
end