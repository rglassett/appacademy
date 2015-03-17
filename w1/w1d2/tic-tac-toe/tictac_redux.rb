class Game
  attr_accessor :board, :player1, :player2, :even_turn
  
  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new("X")
    @player2 = ComputerPlayer.new("O")
    @even_turn = true
  end
  
  def play
    until won?(player1) || won?(player2)
      valid_move = false
      until valid_move
        
        if even_turn # Player 1's turn
          board.display
          next_move = player1.make_move
          if board.empty?(next_move)
            valid_move = true
            board.place_mark(next_move, player1.mark)
            self.even_turn = !even_turn
          else
            puts "Invalid move."
          end
          
        else # Player 2's turn
          next_move = player2.make_move
          if board.empty?(next_move)
            valid_move = true
            board.place_mark(next_move, player2.mark)
            self.even_turn = !even_turn
          end
        end
      end
    end
    board.display
    puts "Congratulations! #{winner} won the game!"
  end
  
  def winner
    if won?(player1)
      "Player One"
    elsif won?(player2)
      "Player Two"
    else
      "Nobody"
    end
  end
  
  def won?(player)
    mark = player.mark
    (board.win_on_row?(mark) || board.win_on_column?(mark)) ||
    board.win_on_diagonals?(mark)
  end
end

class Board
  
  attr_accessor :rows
  
  def initialize(dimension = 3)
    @rows = Array.new(dimension) { Array.new(dimension, " ") }
  end
  
  def display
    puts "-------"
    rows.each_index do |i|
      string = "|"
      rows.each_index do |j|
        string << rows[i][j] << "|"
      end
      puts string
      puts "-------"
    end
  end
  
  def win_on_row?(mark)
    rows.each do |row|
      return true if row.all? { |element| element == mark }
    end
    false
  end
  
  def win_on_column?(mark)
    rows.each_index do |i|
      column = []
      rows.each_index do |j|
        column << rows[j][i]
      end
      return true if column.all? { |element| element == mark }
    end
    false
  end
  
  def win_on_diagonals?(mark)
    diagonal_one = []
    diagonal_two = []
    
    rows.each_index do |i|
      diagonal_one << rows[i][i]
      (0...rows.length).to_a.reverse.each do |j|
        diagonal_two << rows[i][j]
      end
    end
    if diagonal_one.all? { |element| element == mark }
      true
    elsif diagonal_two.all? { |element| element == mark }
      true
    else
      false
    end
  end
  
 
  
  def empty?(pos)
    x, y = pos
    rows[x][y] == " " ? true : false
  end
  
  def place_mark(pos, mark)
    x, y = pos
    rows[x][y] = mark
  end
end

class Player
  attr_accessor :mark
  
  def initialize(mark)
    @mark = mark
  end
end

class HumanPlayer < Player
  def make_move
    print "Choose a position: "
    coords = gets.chomp.split(", ")
    coords.map { |x| x.to_i }
  end
end

class ComputerPlayer < Player
  def make_move
    row = rand(0..2)
    column = rand(0..2)
    array = [row, column]
    array
  end
end

g = Game.new
g.play