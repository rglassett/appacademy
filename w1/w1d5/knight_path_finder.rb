require './00_tree_node'

class KnightPathFinder
  attr_reader :move_tree
  
  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    @move_tree = build_move_tree
  end
  
  def build_move_tree
    node = PolyTreeNode.new(@start_pos)
    queue = [node]
    until queue.empty?
      current_node = queue.shift
      current_new_positions = new_move_positions(current_node.value)
      
      current_new_positions.each do |new_position|
        current_node.give_birth(new_position)
      end
      
      queue.concat(current_node.children)
      @visited_positions << current_node.value
    end
    node
  end
  
  def bf_find_path(end_pos)
    end_node = @move_tree.bfs(end_pos)
    end_node.trace_path_back.map { |node| node.value }.reverse
  end
  
  def df_find_path(end_pos)
    end_node = @move_tree.dfs(end_pos)
    end_node.trace_path_back.map { |node| node.value }.reverse
  end
  
  def new_move_positions(pos)
    new_moves = valid_moves(pos)
    new_moves.reject { |move| @visited_positions.include?(move) }
  end
  
  def valid_moves(pos)
    deltas = [1, -1].product([2, -2]) + [2, -2].product([1, -1])
    
    moves = deltas.map { |delta| [delta[0] + pos[0], delta[1] + pos[1]] }
    moves.select { |move| in_range?(move) }
  end
  
  def in_range?(array)
    array.all? { |x| (0..7).cover?(x) }
  end
  
end

start = [0, 0]
target = [rand(8), rand(8)]

kpf = KnightPathFinder.new(start)

t = Time.new
p kpf.bf_find_path(target)
p "Found path by breadth-first search in #{Time.new - t}!"

t = Time.new
p kpf.df_find_path(target)
p "Found path by depth-first search in #{Time.new - t}!"

# root = kpf.move_tree
#
# def recursive_print(root)
#   parent = root
#   children = parent.children.map { |child| child.value }
#   p "Parent #{parent.value} has children #{children}."
#   parent.children.each { |child| recursive_print(child) }
# end
#
# recursive_print(root)