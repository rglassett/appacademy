def multiplier(array)
  array.map { |i| i * 2 }
end

class Array
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
  end
end

def median(array)
  array = array.sort
  if array.length.odd?
    array[array.length / 2]
  else
    (array[array.length / 2] + array[array.length / 2 - 1]) / 2.0
  end
end

def concatenate(array)
  array.inject { |memo, string| memo + string }
end
