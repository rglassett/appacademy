# encoding: UTF-8
require_relative 'piece'
require 'colorize'

class Board
  attr_reader :size, :rows
  
  def initialize(size=8, setup=true)
    @size = size
    create_rows
    place_pieces if setup
  end
  
  def create_rows
    @rows = Array.new(size) { Array.new(size) }
  end
  
  def place_pieces
    starting_rows = (size / 2) - 1
    black_rows = (0...starting_rows)
    white_rows = (size - starting_rows...size)

    white_rows.each { |row| populate_row(:white, row) }
    black_rows.each { |row| populate_row(:black, row) }
  end
  
  def populate_row(color, row)
    size.times do |col|
      pos = [row, col]
      self[pos] = Piece.new(self, color, pos) if pos.inject(&:+).odd?
    end
  end
  
  def move!(from, to)
    self[from], self[to] = nil, self[from]
    self[to].pos = to
  end
  
  def [](pos)
    raise 'invalid pos' unless valid_pos?(pos)
    x, y = pos
    @rows[x][y]
  end
  
  def []=(pos, piece)
    raise 'invalid pos' unless valid_pos?(pos)
    x, y = pos
    @rows[x][y] = piece
  end
  
  def pieces(color)
    rows.flatten.compact.select { |piece| piece.color == color }
  end
  
  def can_jump?(color)
    jumpables(color).size > 0
  end
  
  def jumpables(color)
    pieces(color).select { |piece| piece.jumps.size > 0 }
  end
  
  def over?
    pieces(:white).empty? || pieces(:black).empty?
  end
  
  def valid_pos?(pos)
    pos.all? { |coord| coord.between?(0, size - 1) }
  end
  
  def display
    header = ("A".."Z").to_a[0...size]
    puts "   #{header.join("  ")}"
    rows.each_with_index do |row, ind1|
      print "#{ind1} "
      row.each_with_index do |el, ind2|
        print "#{print_info([ind1, ind2])}"
      end
      puts
    end
  end
  
  def dup
    duped_board = Board.new(size, false)
    
    rows.flatten.compact.each do |piece|
      piece.dup(duped_board)
    end
    
    duped_board
  end
  
  def print_info(pos)
    bg_color = pos.inject(&:+).odd? ? :red : :light_red
    
    if self[pos].nil?
      str, fg_color = " ", :default
    else
      str = self[pos].to_s
      fg_color = self[pos].color == :white ? :light_white : :black
    end
    
    " #{str} ".colorize(color: fg_color, background: bg_color)
  end
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b.display
end