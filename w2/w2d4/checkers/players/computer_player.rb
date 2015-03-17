class ComputerPlayer
  attr_reader :name
  attr_accessor :color
  
  def initialize(name)
    @name = name
  end
  
  def get_moves(game)
    if game.board.can_jump?(color)
      start = game.board.jumpables(color).sample.pos
      [start, jump_sequence(game, start)]
    else
      moving_piece = game.board.pieces(color).sample
      [moving_piece.pos, [moving_piece.slides.sample]]
    end
  end
  
  def jump_sequence(game, pos)
    duped_board = game.board.dup
    duped_piece = duped_board[pos]
    seq = []
    
    until duped_piece.jumps.empty?
      next_jump = duped_piece.jumps.keys.sample
      duped_piece.perform_jump(next_jump)
      seq << next_jump
    end
    seq
  end
end