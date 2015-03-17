def range(from, to)
  return [] if to < from
  [from] + range(from + 1, to)
end

def recursive_sum_array(array)
  return 0 if array.length == 0
  array[0] + recursive_sum_array(array[1..-1])
end

def iterative_sum_array(array)
  sum = 0
  array.each do |el|
    sum += el
  end
  sum
end

def exp1(b, n)
  return 1 if n == 0
  return b if n == 1
  b * exp1(b, n - 1)
end

def exp2(b, n)
  return 1 if n == 0
  return b if n == 1
  if n.even?
    exp2(b, n / 2) ** 2
  else
    b * (exp2(b, (n - 1) / 2) ** 2)
  end
end

class Array
  def deep_dup
    new_array = []
    self.each do |el|
      if el.is_a?(Array)
        new_array << el.deep_dup
      else
        new_array << el
      end
    end
    new_array
  end
end

def rfibs(n)
  return [] if n == 0
  return [0] if n == 1
  return [0, 1] if n == 2
  previous = rfibs(n - 1)
  previous << previous[-1] + previous[-2]
end

def ifibs(n)
  return [] if n == 0
  return [0] if n == 1
  numbers = [0, 1]
  (n - 2).times do |i|
    numbers << numbers[-1] + numbers[-2]
  end
  numbers
end

def bsearch(array, target)
  return nil if array.length == 0
  
  center = array.length / 2
  
  return center if array[center] == target
  
  if array[center] < target
    return center + bsearch(array[center..-1], target)
  else
    return bsearch(array[0...center], target)
  end
end

def make_change(amount, coins)
  return [] if coins.empty?
  return [] if amount == 0

  combos = []

  coins.each do |coin|
    if amount >= coin
      change = make_change(amount - coin, coins)
      change << coin
      combos << change
    end
  end

  combos.min_by { |arr| arr.length }
end

def merge_sort(array)
  return array if array.length <= 1
  
  half_length = array.length / 2
  array_1 = array[0...half_length]
  array_2 = array[half_length..-1]
  
  merge(merge_sort(array_1), merge_sort(array_2))
end

def merge(array_1, array_2)
  sorted = []

  until array_1.empty? || array_2.empty?
    val1 = array_1[0]
    val2 = array_2[0]
    if val1 < val2
      sorted << array_1.shift
    else
      sorted << array_2.shift
    end
  end
  
  sorted + array_1 + array_2
end

def subsets(array) # [1]
  return [[]] if array.empty?
  
  last = subsets(array[0..-2])
  total = []
  
  last.each do |ss|
    total << ss
    total << ss + [array[-1]]
  end
  
  total.sort
end

