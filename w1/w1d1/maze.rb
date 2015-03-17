MAZE = [
  ['*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*'], #0
  ['*',' ',' ',' ',' ',' ',' ',' ',' ',' ','*',' ',' ',' ','E','*'], #1
  ['*',' ',' ',' ',' ','*',' ',' ',' ',' ','*',' ',' ','*','*','*'], #2
  ['*',' ',' ',' ',' ','*',' ',' ',' ',' ','*',' ',' ',' ',' ','*'], #3
  ['*',' ',' ',' ',' ','*',' ',' ',' ',' ','*',' ',' ',' ',' ','*'], #4
  ['*',' ',' ',' ',' ','*',' ',' ',' ',' ','*',' ',' ',' ',' ','*'], #5
  ['*','S',' ',' ',' ','*',' ',' ',' ',' ',' ',' ',' ',' ',' ','*'], #6
  ['*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*']  #7
]

def solve_maze(start_pos, end_pos) # array [x coord, y coord]
  
  options = [
    [start_pos[0] - 1, start_pos[1]],
    [start_pos[0] + 1, start_pos[1]],
    [start_pos[0], start_pos[1] + 1],
    [start_pos[0], start_pos[1] - 1]
  ]
  
 # valid_options = options.select { |x| valid_move?(x[0], x[1]) }
  
  options.each do |x, y|
    if valid_move?(x, y)
      puts [x, y].to_s
    end
  end
  
end

def valid_move?(x,y)
  return false if x >= MAZE.length || y >= MAZE[0].length   
  if MAZE[x][y] == ' '
    true
  else
    false
  end
end

def move_closeness(start_pos, end_pos)
  ((end_pos[0] + 1 - start_pos[0] + 1)**2 + (end_pos[1] + 1 - start_pos[1] + 1)**2)**(0.5)
end

solve_maze([6, 1], [1, 14])
puts move_closeness([6,1], [1, 14])