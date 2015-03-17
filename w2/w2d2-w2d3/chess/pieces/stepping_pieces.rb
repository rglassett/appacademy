# encoding: UTF-8
class SteppingPiece < Piece
  
  def moves
    proto_moves.select { |move| takeable?(move) }.uniq
  end
  
  def proto_moves
    @offsets.map { |offset| [offset[0] + @pos[0], offset[1] + @pos[1]] }
  end
end

class Knight < SteppingPiece
  
  def initialize(color, board, pos)
    @offsets = [1, -1].product([2, -2]) + [2, -2].product([1, -1])
    super
  end
  
  def symbol
    '♞'
    # color == :Black ? '♞' : '♘'
  end
end

class King < SteppingPiece
  
  def initialize(color, board, pos)
    @offsets = DIAGONALS + STRAIGHTS
    super
  end
  
  def symbol
    '♚'
    # color == :Black ? '♚' : '♔'
  end
  
end

class Pawn < Piece
  
  attr_accessor :vulnerable
  
  def initialize(color, board, pos)
    super
    @capture_offsets = [[-1, 1], [-1, -1]]
    @advance_offsets = [[-1, 0], [-2, 0]]
    @vulnerable = false
    
    if @color == :Black
      flip_direction!(@capture_offsets)
      flip_direction!(@advance_offsets)
    end
  end
  
  def flip_direction!(moves)
    moves.map! { |x, y| [x*-1 , y* -1] }
  end
  
  def moves
    (captures + advances)
  end
  
  def move_to(pos)
    distance = (pos[0] - @pos[0]).abs
    if distance == 2
      @vulnerable = true
    end
    
    targ = passant_target(pos)
    #Adjusted so we call passant_target before actual move 'super'
    #but don't remove the target until after the 'super'
    super
    
    if targ
      @board[targ] = nil
    end
    @advance_offsets = [@advance_offsets[0]]
    
  end
  
  def proto_moves(moves)
    moves.map do |move|
      [move[0] + pos[0], move[1] + pos[1]]
    end.select { |move| in_range?(move) }
  end
  
  def captures
    options = proto_moves(@capture_offsets)
    options.select do |move|
      (@board[move] && @board[move].color != color) || passant_target(move)
    end
  end
  
  def passant_target(to)
    target_pawn = @board[[@pos[0], to[1]]]
    
    if !@board[to].nil?
      # puts "En passant destination must be empty!"
      return false
    elsif target_pawn.nil? || !target_pawn.is_a?(Pawn)
      # puts "Cannot En Passant without a target pawn!"
      return false
    elsif !target_pawn.vulnerable
      # puts "Target pawn is not vulnerable to En Passant!"
      return false
    end
    
    [@pos[0], to[1]]
  end
  
  def advances
    options = proto_moves(@advance_offsets)   
    return [] if @board[options[0]]
    options.pop if options[1] && @board[options[1]]
    options
  end
  
  def promote
    @board[@pos] = Queen.new(@color, @board, @pos.dup)
  end
  
  def symbol
    '♟'
    # color == :Black ? '♟' : '♙'
  end
end

# Pawns are either @vulnerable or not
# Pawns become vulnerable after moving two spaces
# Pawns check to their left/right for @vulnerable pawns
# If they find a @vulnerable pawn, they get a capture move
#
#
#