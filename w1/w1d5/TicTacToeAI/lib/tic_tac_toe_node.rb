require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    opponent_mark = @next_mover_mark == :x ? :o : :x
    positions = [0, 1, 2].product([0, 1, 2])
    
    positions.each do |pos|
      if board.empty?(pos)
        duped_board = board.dup
        duped_board[pos] = next_mover_mark
        children << TicTacToeNode.new(duped_board, opponent_mark, pos)
      end
    end
    
    children
  end

  def losing_node?(evaluator)
    opponent = evaluator == :x ? :o : :x
    return true if board.over? && board.winner == opponent
    return false if board.over? && (board.winner == evaluator || board.winner.nil?)
    
    if next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    opponent = evaluator == :x ? :o : :x
    return true if board.over? && board.winner == evaluator
    return false if board.over? && (board.winner == opponent || board.winner.nil?)
    
    if next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end
end

# empty_board_node = TicTacToeNode.new(Board.new, :x)
#
# kids = empty_board_node.children.map { |kid| kid.prev_move_pos }
# p "Kids: #{kids}"
# positions = [0,1,2].product([0,1,2])
# p "Positions: #{positions}"
# p (kids - positions)