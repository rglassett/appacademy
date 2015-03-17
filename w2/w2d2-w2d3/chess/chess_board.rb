# encoding: UTF-8

require './pieces.rb'
require "./exceptions.rb"
require 'colorize'

class Board
  
  def initialize(setup=true)
    @rows = Array.new(8) { Array.new(8) }
    setup_pieces if setup
  end
  
  def move(from, to, color)
    raise NoPieceError.new("Space empty!") if self[from].nil?
    raise TurnError.new("Wrong color!") if self[from].color != color
    if can_castle?(from, to)
      castle(from, to)
    else
      self[from].move_to(to)
    end
    reset_passants(get_opponent(color))
  end
  
  def reset_passants(color)
    pawns = get_pieces(color).select { |piece| piece.is_a?(Pawn) }
    
    pawns.each do |pawn|
      if pawn.vulnerable
        pawn.vulnerable = false
      end
    end
  end
  
  def move!(from, to)
    self[to], self[from] = self[from], nil 
    self[to].pos = to
  end
  
  def [](pos)
    x, y = pos
    @rows[x][y]
  end
  
  def []=(pos, value)
    x, y = pos
    @rows[x][y] = value
  end
  
  def dup
    new_board = Board.new(false)
    (0..7).to_a.product((0..7).to_a).each do |pos|
      new_board[pos] = self[pos].dup(new_board) if self[pos]
    end
    new_board
  end
  
  def display
    puts "   #{("A".."H").to_a.join("  ")}"
    
    @rows.each_with_index do |row, ind1|
      print "#{8 - ind1} "
      row.each_with_index do |el, ind2|
        print "#{print_info([ind1, ind2])}"
      end
      puts
    end
  end
  
  def print_info(pos)
    if self[pos].nil? || self[pos].color == :Black
      foregound_color = :black
    else
      foregound_color = :light_white
    end
    char = self[pos].nil? ? " " : self[pos].to_s
    if pos.count(&:odd?) == 1
      " #{char} ".colorize( background: :light_blue, color: foregound_color)
    else
      " #{char} ".colorize( background: :cyan, color: foregound_color)
    end
  end
  
  def castle(from, to)
    king = self[from]
    rook = castling_rook(from, to)
    move!(from, to)
    move!(rook.pos, castle_destination(from, to))
  end
  
  def spaces_between(from, to)
    if from[0] != to[0]
      raise "can only get spaces between two points on the same row."
    end
    
    x = from[0]
    
    if from[1] < to[1]
      low, hi = from[1] + 1, to[1] - 1
    else
      low, hi = to[1] + 1, from[1] - 1
    end
    
    [x].product((low..hi).to_a)
  end
  
  def castling_empties(rook_pos, king_pos)
    spaces_between(rook_pos, king_pos)
  end
  
  def castling_threats(from, to)
    spaces_between(from, to) + [to]
  end
  
  def castle_destination(from, to)
    from[1] < to[1] ? [to[0], to[1] - 1] : [to[0], to[1] + 1]
  end
  
  def can_castle?(from, to)
    king = self[from]
    return false unless king.is_a?(King) && (from[1] - to[1]).abs == 2
    
    rook = castling_rook(from, to) 
    if !rook.is_a?(Rook)
      raise InvalidCastleError.new("Can't castle without a rook!")
    elsif king.moved? || rook.moved?
      raise InvalidCastleError.new("Can't castle with pieces that have moved!")
    elsif castling_empties(rook.pos, king.pos).any? { |move| !self[move].nil? }
      raise InvalidCastleError.new("Cannot castle through other pieces!")
    elsif castling_threats(from, to).any? { |move| king.move_into_check?(move) }
      raise InvalidCastleError.new("Cannot castle through threatened spaces!") 
    end
    
    true
  end
  
  def castling_rook(from, to)
    if from[1] > to[1]
      pos = [to[0], to[1] - 2] # Queenside rook is 2 left of destination
    else
      pos = [to[0], to[1] + 1] # Kingside rook is 1 right of destination
    end
    self[pos]
  end
  
  def in_check?(color)
    get_moves(get_opponent(color)).include?(king(color).pos)
  end
  
  def over?
    draw? || (checkmate?(:White) || checkmate?(:Black))
  end
  
  def draw?
    stalemate?(:White) || stalemate?(:Black)
  end
  
  def winner
    return :Black if checkmate?(:White)
    return :White if checkmate?(:Black)
    nil
  end
  
  private
  def stalemate?(color)
    get_valid_moves(color).empty? && !in_check?(color)
  end
  
  def checkmate?(color)
    in_check?(color) && get_valid_moves(color).empty?
  end
  
  def get_opponent(color)
    color == :Black ? :White : :Black
  end
  
  def get_moves(color)
    get_pieces(color).map { |piece| piece.moves }.flatten(1).uniq
  end
  
  def get_pieces(color)
    @rows.flatten.select { |el| el && el.color == color }
  end
  
  def get_valid_moves(color)
    get_pieces(color).map { |piece| piece.valid_moves }.flatten(1).uniq
  end
  
  def king(color)
    get_pieces(color).find { |piece| piece.is_a?(King) }
  end
  
  def place_pieces(color, arrangements)
    arrangements.each do |klass, positions|
      positions.each do |pos|
        self[pos] = klass.new(color, self, pos)
      end
    end
  end
  
  def setup_pieces
    # black_pieces = {
    #   Pawn => [1].product((0..7).to_a),
    #   Rook => [[0, 0], [0, 7]],
    #   Knight => [[0, 1], [0, 6]],
    #   Bishop => [[0, 2], [0, 5]],
    #   Queen => [[0, 3]],
    #   King => [[0, 4]]
    # }
    #
    # white_pieces = {
    #   Pawn => [6].product((0..7).to_a),
    #   Rook => [[7, 0], [7, 7]],
    #   Knight => [[7, 1], [7, 6]],
    #   Bishop => [[7, 2], [7, 5]],
    #   Queen => [[7, 3]],
    #   King => [[7, 4]]
    # }
    
    black_pieces = {
      Pawn => [1].product((0..7).to_a),
      Rook => [[0, 0], [0, 7]],
      Knight => [[0, 1], [0, 6]],
      Bishop => [[0, 2], [0, 5]],
      Queen => [[0, 3]],
      King => [[0, 4]]
    }

    white_pieces = {
      Pawn => [4].product((0..7).to_a),
      Rook => [[7, 0], [7, 7]],
      Knight => [[7, 1], [7, 6]],
      Bishop => [[7, 2], [7, 5]],
      Queen => [[7, 3]],
      King => [[7, 4]]
    }
    
    place_pieces(:White, white_pieces)
    place_pieces(:Black, black_pieces)
  end
end