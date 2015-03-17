# encoding: UTF-8
require "./exceptions.rb"

class Piece
  
  attr_accessor :color, :pos
  
  DIAGONALS = [
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ]
  
  STRAIGHTS = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0]
  ]
  
  def initialize(color, board, pos)
    @color, @board, @pos = color, board, pos
    @moved = false
  end
  
  def moved?
    @moved
  end
  
  def dup(new_board)
    self.class.new(color, new_board, pos.dup)
  end
  
  def takeable?(pos)
    return false unless in_range?(pos)
    space = @board[pos]
    space.nil? || space.color != @color
  end
  
  def in_range?(move)
    move.all? { |x| x.between?(0, 7) }
  end
  
  def to_s
    symbol
  end
  
  def move_into_check?(move)
    new_board = @board.dup
    new_board.move!(pos, move)
    new_board.in_check?(color)
  end
  
  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end
  
  def symbol
    raise NotImplementedError
  end
  
  def move_to(destination)
    if valid_moves.include?(destination)
      @board[destination], @board[@pos] = self, nil
      @pos = destination
      self.promote if self.is_a?(Pawn) && [0, 7].include?(destination[0])
      @moved = true
    else
      raise InvalidMoveError.new("Invalid move!")
    end
  end
end



