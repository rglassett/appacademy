class PolyTreeNode
  attr_accessor :children
  attr_reader :value
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def give_birth(value)
    add_child(PolyTreeNode.new(value))
  end
  
  def parent
    @parent
  end
  
  def parent=(node)
    @parent.children.delete(self) if @parent
    @parent = node
    unless @parent == nil
      @parent.children << self unless @parent.children.include?(self)
    end
  end
  
  def add_child(node)
    node.parent = self
  end
  
  def remove_child(node)
    raise "No such child" unless @children.include?(node)
    node.parent = nil
  end
  
  def dfs(target)
    return self if value == target
    @children.each do |child|
      result = child.dfs(target)
      return result if result
    end
    nil
  end
  
  def bfs(target)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target
      queue.concat(current_node.children)
    end
    nil
  end
  
  def trace_path_back
    path = []
    node = self
    until node.nil?
      path << node
      node = node.parent
    end
    path
  end
  
end
