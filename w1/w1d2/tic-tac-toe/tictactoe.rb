class Board
  attr_accessor :board
  
  def initialize(dimension = 3)
    @board = Array.new(dimension) { Array.new(dimension, " ") }
  end
  
  def won?(player)
    if (win_on_row?(player) || win_on_column?(player)) || win_on_diagonals?(player)
      true
    else
      false
    end
  end
  
  def win_on_row?(player)
    board.each do |row|
      return true if row.all? { |mark| mark == player.mark }
    end
    false
  end
  
  def win_on_column?(player)
    board.each_index do |i|
      column = []
      board.each_index do |j|
        column << board[j][i]
      end
      return true if column.all? { |mark| mark == player.mark }
    end
    false
  end
  
  def win_on_diagonals?(player)
    diagonal_one = []
    diagonal_two = []
    
    board.each_index do |i|
      diagonal_one << board[i][i]
      (0...board.length).to_a.reverse.each do |j|
        diagonal_two << board[i][j]
      end
    end
    if diagonal_one.all? { |mark| mark == player.mark }
      true
    elsif diagonal_two.all? { |mark| mark == player.mark }
      true
    else
      false
    end
  end
  
  def winner
  end
  
  def winning_position?(pos, player)
    cloned_board = board.clone
    cloned_board.place_mark([i, j])
    if cloned_board.won?(player)
      true
    else
      false
    end
  end
  
  def empty_position?(pos) # pos is an array of the form [x, y]
    x, y = pos
    board[x][y] == " " ? true : false
  end
  
  def place_mark(pos, mark)
    x, y = pos
    board[x][y] = mark
  end
  
  def display
    puts "-------"
    board.each_index do |i|
      string = "|"
      board.each_index do |j|
        string << board[i][j] << "|"
      end
      puts string
      puts "-------"
    end
  end
  
end

class Game
  attr_accessor :board, :current_player, :player1, :player2
  
  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new("X", self)
    @player2 = ComputerPlayer.new("O", self)
    @current_player = @player1
  end
  
  def play
    until board.won?(current_player)
      game_over = false
      until game_over
        current_player.make_move
        if board.won?(current_player)
          game_over = true
          board.display
        else
          switch_player
        end
      end
    end
    puts "Congratulations, #{current_player.class} won!"
  end
  
  def switch_player
    if current_player == player1
      self.current_player = player2
    else
      self.current_player = player1
    end
  end
        
end


class Player
  
  attr_accessor :mark
  attr_reader :game, :board
  
  def initialize(mark, game)
    @mark = mark
    @game = game
    @board = game.board
  end
  
end

class HumanPlayer < Player
  def make_move
    while true
      board.display
      print "Enter a move of format: [row, column]> "
      coords = gets.chomp.split(", ")
      coords.map! { |x| x.to_i }

      if board.empty_position?(coords)
        board.place_mark(coords, mark)
        break
      else
        puts "Invalid move."
      end
    end
  end
end

class ComputerPlayer < Player
  def make_move
    empty_spaces(board).each do |space|
      board = board.board
      if board.winning_position(space, self)
        board.place_mark(space, mark)
        return
      end    
    end
    
    board.place_mark(empty_spaces(board).sample)
  end
  
  def empty_spaces(board)
    spaces = []
    
    cloned_board = board.board.clone
    p board
    cloned_board.each_index do |i|
      cloned_board.each_index do |j|
        if board.empty_position?([i, j])
          spaces << [i, j]
        end
      end
    end
    
    spaces
  end
  
  
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end