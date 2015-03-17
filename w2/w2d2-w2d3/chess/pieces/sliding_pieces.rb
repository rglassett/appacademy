# encoding: UTF-8
class SlidingPiece < Piece
  
  def moves
    @move_dirs.map { |dir| next_steps(@pos, dir) }.flatten(1)
  end
  
  def next_steps(pos, dir)
    new_pos = [pos[0] + dir[0], pos[1] + dir[1]]
    return [] unless takeable?(new_pos)
    return [new_pos] if @board[new_pos]
    next_steps(new_pos, dir).unshift(new_pos)
  end
end

class Bishop < SlidingPiece
  
  def initialize(color, board, pos)
    @move_dirs = DIAGONALS
    super
  end
  
  def symbol
    '♝'
    # color == :Black ? '♝' : '♗'
  end
end

class Rook < SlidingPiece
  
  def initialize(color, board, pos)
    @move_dirs = STRAIGHTS
    super
  end
  
  def symbol
    '♜'
    # color == :Black ? '♜' : '♖'
  end
end

class Queen < SlidingPiece
  
  def initialize(color, board, pos)
    @move_dirs = DIAGONALS + STRAIGHTS
    super
  end
  
  def symbol
    "♛"
    # color == :Black ? "♛" : '♕'
  end
end