# encoding: UTF-8
require_relative 'exceptions.rb'

class Piece
  attr_reader :board, :color
  attr_accessor :pos, :king
  
  def initialize(board, color, pos, king=false)
    @board, @color, @pos, @king = board, color, pos, king
  end
  
  def dup(duped_board)
    duped_board[pos] = Piece.new(duped_board, color, pos.dup, king)
  end
  
  def legal_jump?(target, destination)
    return false unless board.valid_pos?(target) && board.valid_pos?(destination)
    return false unless board[target] && board[target].color != color
    return false unless board[destination].nil?
    true
  end
  
  def jumps
    target_diffs = move_dirs.product([1, -1])
    jumps = Hash.new
    
    target_diffs.each do |diff|
      target = [diff[0] + pos[0], diff[1] + pos[1]]
      destination = [target[0] + diff[0], target[1] + diff[1]]
      jumps[destination] = target if legal_jump?(target, destination)
    end
    
    jumps
  end
  
  def perform_jump(jump)
    raise InvalidMoveError.new("Invalid jump!") unless jumps.has_key?(jump)
    target_pos = jumps[jump]
    
    board.move!(pos, jump)
    board[target_pos] = nil
    true
  end
  
  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence, true)
      try_promoting
    else
      raise InvalidMoveError.new("buh?")
    end
  end
  
  def perform_moves!(move_sequence, display=false)
    if move_sequence.count == 1 && slides.include?(move_sequence[0])
      perform_slide(move_sequence[0])
    else
      
      move_sequence.each do |move|
        if display
          system 'clear'
          board.display
        end
        perform_jump(move)
      end
      
      raise InvalidMoveError.new("Jumps still remain.") unless jumps.empty?
    end
  end
  
  def slides
    slides = move_dirs.product([1, -1])
    
    slides.map! { |slide| [slide[0] + pos[0], slide[1] + pos[1]] }
    slides.select { |slide| @board.valid_pos?(slide) && @board[slide].nil? }
  end
  
  def to_s
    king? ? "★" : "☻"
  end
  
  private
  def forward_direction
    color == :white ? -1 : 1
  end
  
  def king?
    king
  end
  
  def move_dirs
    king? ? [forward_direction, -forward_direction] : [forward_direction]
  end
  
  def perform_slide(slide)
    if board.can_jump?(color)
      raise InvalidMoveError.new("Must jump if possible!") 
    elsif !slides.include?(slide)
      raise InvalidMoveError.new("Invalid slide!")
    end
    
    board.move!(pos, slide)
    true
  end
  
  def try_promoting
    self.king = true if pos[0] == 0 || pos[0] == board.size - 1
  end
  
  def valid_move_seq?(move_sequence)
    duped_board = board.dup
    duped_piece = duped_board[pos]
    duped_piece.perform_moves!(move_sequence)
    true
  end
end