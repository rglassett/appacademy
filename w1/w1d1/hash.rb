class MyHashSet
  
  def initialize
    @store = {}
  end
  
  def insert(el)
    @store[el] = true
  end
  
  def include?(el)
    @store[el] == nil ? false : true
  end
  
  def delete(el)
    included = self.include?(el)
    @store.delete(el) if included
    included
  end
  
  def to_s
    @store.to_s
  end
  
  def to_a
    @store.keys
  end
  
  def union(set2)
    result = MyHashSet.new
    (set2.to_a + self.to_a).each do |key|
      result.insert(key)
    end
    result   
  end
  
  def intersect(set2)
    result = MyHashSet.new
    self.to_a.each do |key|
      result.insert(key) if set2.include?(key)
    end
    result
  end
  
  def minus(set2)
    result = MyHashSet.new
    self.to_a.each do |key|
      result.insert(key) unless set2.include?(key)
    end
    result
  end
   
end

a = MyHashSet.new
b = MyHashSet.new

a.insert('stuff')
a.insert('things')

b.insert("purple")
b.insert("yellow")
b.insert("things")

puts a.minus(b)