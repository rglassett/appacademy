class PolyTreeNode
  attr_accessor :children
  attr_reader :parent, :value
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    @parent.children.delete(self) if @parent
    @parent = node
    @parent.children << self if @parent
  end
  
  def add_child(child_node)
    child_node.parent = self
  end
  
  def remove_child(child_node)
    child_node.parent = nil
  end
  
end

a = PolyTreeNode.new("a")
b = PolyTreeNode.new("b")
c = PolyTreeNode.new("c")

a.parent = b

p "a is a node with parent #{a.parent} and children #{a.children}"
p "b is a node with parent #{b.parent} and children #{b.children}"
p "c is a node with parent #{c.parent} and children #{c.children}"

puts
p "Switching parents!"
puts

b.remove_child(a)

p "a is a node with parent #{a.parent} and children #{a.children}"
p "b is a node with parent #{b.parent} and children #{b.children}"
p "c is a node with parent #{c.parent} and children #{c.children}"