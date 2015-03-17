require './tile.rb'

class Board
  attr_reader :rows, :dimension
  attr_accessor :lost
  
  def initialize(dimension = 9)
    @lost = false
    @dimension = dimension 
    @bomb_count = dimension
    @rows = Array.new(dimension) { Array.new(dimension) }
    
    dimension.times do |row|
      dimension.times do |col|
        @rows[row][col] = Tile.new(self, [row, col])
      end
    end    
    seed_bombs
    assign_values
  end
  
  def [](x, y)
    @rows[x][y]
  end
  
  def display
    temp = []
    @rows.each do |row|     
      temp << row.map {|el| el.to_s}.join("  ")
      
    end
    count = 0
    puts "     " + (0...@dimension).to_a.join("  ")
    puts "    " + " _ " * @dimension
    temp.each do |row|
      puts "#{count}  | #{row}"
      count += 1
    end
  end
  
  def assign_values
    @rows.each do |row|
      row.each do |tile|
        tile.assign_value
      end
    end
  end
  
  def seed_bombs
    num = @dimension
    
    while num > 0
      next_tile = @rows[rand(@dimension)][rand(@dimension)]
      num -= 1 if next_tile.try_place_bomb
    end
  end
  
  def in_range?(coords)
    coords.all? { |x| (0...@dimension).cover?(x) }
  end
  
  def won?
    @rows.each do |row|
      row.each do |tile|
        return false if tile.revealed == false && tile.value != :b
      end
    end
    true
  end
  
  def lost?
    @lost
  end
  
  def over?
    won? || lost?
  end
end