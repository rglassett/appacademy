class MazeSolver
  attr_reader :rows_array, :path, :start_point, :end_point
  
  def initialize
    @rows_array = read_maze_file
    @start_point = []
    @end_point = []
    @path = []
    find_terminals
  end
  
  def read_maze_file
    File.readlines("maze.txt").map do |line|
      line.chomp.split(//)
    end
  end
  
  def find_terminals
    (0...@rows_array.length).each do |row|
      (0...@rows_array[0].length).each do |column|
        @start_point = [row, column] if @rows_array[row][column] == "S"
        @end_point = [row, column] if @rows_array[row][column] == "E"
      end
    end
    [@start_point, @end_point]
  end
  
  def get_neighbors(position)
    y, x = position[0], position[1]
    north = [y - 1, x] 
    south = [y + 1, x]
    east = [y, x + 1]
    west = [y, x - 1]
    neighbors = [north, south, east, west].reject { |pos| valid?(pos) }
    neighbors
  end
  
  def valid?(position)
    y, x = position[0], position[1]
    return false if y < 0 || x < 0
    return false if y > @rows_array.length || x > @rows_array[0].length
    return false if @rows_array[y][x] == "*"
    return true if @rows_array[y][x] == "E"
    return false if @rows_array[y][x] != " "
  end
  
  def empty_space?(position)
    y, x = position[0], position[1]
    @rows_array[y][x] == " "
  end

  def solve_maze(position)
    puts "Now traversing #{position}..."
    neighbors = get_neighbors(position)
    if neighbors.include?(@end_point)
      @path << position
      return true
    elsif neighbors.any? { |neighbor| solve_maze(neighbor) }
      @path << position
      return true
    else
      false
    end
    #go through NSEW
    # neighbors.each do |neighbor|
    #   if empty_space(neighbor)
    #     solve_maze(neighbor)
    #   end
    # end
        
    #iterate through all positions
    
    #breadth first search
    #check_neighbors
  end
  
  def solve_maze2(position)
    neighbors = get_neighbors(position)
    if neighbors.include?(@end_point)
      return position
    else
      while true
        neighbors.each do |neighbor|
          if empty_space(neighbor)
            @path << neighbor
            solvemaze2(neighbor)
          end
        end
      end
    end
  end
  
end

m = MazeSolver.new
m.solve_maze(m.start_point)
m.path

# if __FILE__ == $PROGRAM_NAME
#   maze_file_name = ARGV[0]
#   maze_solver(maze_file_name)
# end