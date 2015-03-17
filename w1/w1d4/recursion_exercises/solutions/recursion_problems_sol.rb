#Problem 1: You have array of integers. Write a recursive solution to find the sum of the integers.

def sum_recur(array)
  dup_array = array.dup
  return 0 if dup_array.count == 0
  dup_array.pop + sum_recur(dup_array)
end


#Problem 2: You have array of integers. Write a recursive solution to determine
#whether or not the array contains a specific value.

def includes?(array, target)
  dup_array = array.dup
  return false if dup_array.count == 0
  return true if dup_array.pop == target
  includes?(dup_array, target)
end

#Problem 3: You have an unsorted array of integers. Write a recursive solution to count the number of occurrences of a specific value.

def num_occur(array, target, counter = 0, &blk)
  dup_array = array.dup
  blk.call if dup_array.count == 0
  counter += 1 if dup_array.pop == target
  num_occur(dup_array, target, counter){return counter}
end

#Problem 4: You have array of integers. Write a recursive solution to determine whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  dup_array = array.dup
  return false if dup_array.count - 1 == 0
  return true if dup_array.pop + dup_array.last == 12
  add_to_twelve?(dup_array)
end

#Problem 5: You have array of integers. Write a recursive solution to determine if the array is sorted.

def sorted?(array)
  return [] if array.empty?
  dup_array = array.dup
  return true if dup_array.count - 1 == 0
  return false if dup_array.pop < dup_array.last
  sorted?(dup_array)
end

#Problem 6: Write the code to give the value of a number after it is reversed. (Don't use any #reverse methods!)

def reverse(number, reversed = [])
  dup_number = number.to_s.dup
  return reversed.join("").to_i if dup_number.to_i == 0
  split_number = dup_number.split("")
  popped = split_number.pop
  reversed.push(popped)
  dup_number = split_number.join("").to_i
  reverse(dup_number, reversed)
end

