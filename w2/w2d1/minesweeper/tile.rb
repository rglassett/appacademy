class Tile
  attr_reader :position, :board, :revealed
  attr_accessor :value
  
  def initialize(board, position)
    @board = board
    @value, @flagged, @revealed, @position = 0, false, false, position
  end
  
  def change_flag
    @flagged = !@flagged
  end

  def reveal
    if @value == :b
      @board.lost = true
    end
    @revealed = true
    
    if @value == 0
      neighbors.each { |neighbor| neighbor.reveal unless neighbor.revealed }
    end
  end
  
  def to_s
    return "F" if @flagged
    if @revealed 
      return value.to_s if value != 0
      return "~" if value == 0
      return "B" if value == :b
    else
      "*"
    end
  end
  
  def neighbors
    deltas = [
      [-1, -1], [-1, 0], [-1, 1], [0, -1],
      [0, 1], [1, -1], [1, 0], [1, 1]
    ]
    
    neighbors = deltas.map do |coord|
      [coord[0] + @position[0], coord[1] + @position[1]]
    end
    
    neighbors.select! { |coords| @board.in_range?(coords) }
    neighbors.map { |pos| @board[pos[0], pos[1]] }
  end
  
  def assign_value
    return if @value == :b
    neighbors, count = self.neighbors, 0
    
    neighbors.each do |tile|
      count += 1 if tile.value == :b
    end
    
    @value = count
  end
  
  def try_place_bomb
    return false if @value == :b
    @value = :b
    true
  end
end