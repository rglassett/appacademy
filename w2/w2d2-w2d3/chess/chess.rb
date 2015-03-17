# encoding: UTF-8
# Todo: colorize, pawn promotion, stalemate, castling, en passant
require "./chess_board.rb"
require "./exceptions.rb"

class ChessGame
  def initialize
    @board = Board.new
    @current_player = :White
  end
  
  def play
    until @board.over?
      play_turn
    end
    
    @board.display
    if @board.winner
      puts "#{@board.winner} wins!"
    else
      puts "Stalemate."
    end
  end
  
  def play_turn
    system 'clear'
    
    @board.display
    
    begin
      puts '*' * 33
      input = get_user_input
      from, to = parse_move(input[0]), parse_move(input[1])
      @board.move(from, to, @current_player)
    rescue ChessError  => err
      puts err.message
      retry
    end
    
    switch_player
  end
  
  def switch_player
    @current_player = @current_player == :White ? :Black : :White
  end
  
  def prompt
    puts "--#{@current_player}'s turn--"
    puts "Enter the start square and end square of your move (A1 B2): "
  end
  
  def get_user_input
    prompt
    choice = gets.chomp.upcase
    raise InvalidInputError.new("Invalid input!") unless valid_input?(choice)
    choice.split
  end
  
  def valid_input?(input)
    /^[A-H][1-8] [A-H][1-8]$/.match(input)
  end
  
  def parse_move(move)
    x = 8 - move[1].to_i
    y = ('A'..'H').to_a.index(move[0])
    [x, y]
  end
end

if __FILE__ == $PROGRAM_NAME
  c = ChessGame.new
  c.play
end