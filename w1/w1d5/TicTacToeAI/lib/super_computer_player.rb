require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    children = node.children
    best_move = nil
    
    children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
      best_move = child.prev_move_pos unless child.losing_node?(mark)
    end
    
    best_move == nil ? raise("Rats, foiled again!") : best_move
  end
end

if __FILE__ == $PROGRAM_NAME
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(cp, hp).run
end
