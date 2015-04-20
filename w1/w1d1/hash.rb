class MyHashSet
  def initialize
    @store = Hash.new(false)
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    @store.has_key?(el)
  end

  def delete(el)
    @store.delete(el)
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
