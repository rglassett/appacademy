class Array
  def quicksort
    return self if count <= 1
    pivot = sample
    left, right = [], []
    self.each do |el|
      el <= pivot ? left << el : right << el
    end
    left.quicksort + right.quicksort
  end
  
  def bogosort
    ordered_array = self.sort
    shuffle! until self == ordered_array
  end
end

test_array = (1..10).to_a.shuffle
t = Time.new
test_array.quicksort
p "Completed quicksort on #{test_array.length} elements in #{Time.new - t}!"

t = Time.new
test_array.bogosort
p "Completed bogosort on #{test_array.length} elements in #{Time.new - t}!"