class Array
  def my_each(&blk)
    self.length.times do |i|
      blk.call self[i]
    end
  end

  def my_map(&blk)
    arr = []
    self.my_each do |el|
      arr << blk.call(el)
    end
    arr
  end

  def my_select(&blk)
    arr = []
    self.my_each do |el|
      arr << el if blk.call(el)
    end
    arr
  end
  
  def my_inject(&blk)
    return nil if self.length == 0
    sum = self[0]
    self[1..-1].my_each do |el|
      sum = blk.call(sum, el)
    end
    sum
  end
  
  def my_sort!(&blk)
    unsorted = true
    
    while unsorted
      unsorted = false
      
      (self.length - 1).times do |i|
        if blk.call(self[i], self[i + 1]) == 1
          self[i], self[i + 1] = self[i + 1], self[i]
          unsorted = true
        end
      end
    end
    
    self
  end
  
  def my_sort(&blk)
    self.dup.my_sort!(&blk)
  end
end

def eval_block(*args, &blk)
  if blk.nil?
    puts "NO BLOCK GIVEN"
    return
  end
  
  args.each do |arg|
    blk.call(arg)
  end
end

eval_block(1, 2, 3) 