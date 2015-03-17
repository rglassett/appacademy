#Problem 1: You have array of integers. Write a recursive solution to find
#the sum of the integers.

def sum_recur(array)
  return 0 if array.empty?
  val = array.last
  val + sum_recur(array.take(array.length - 1))
end


#Problem 2: You have array of integers. Write a recursive solution to
#determine whether or not the array contains a specific value.

def includes?(array, target)
  return true if array.first == target
  return false if array.empty?
  includes?(array.drop(1), target)
end


#Problem 3: You have an unsorted array of integers. Write a recursive
#solution to count the number of occurrences of a specific value.

# [1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6]
# 5

def num_occur(array, target)
  return 0 if array.empty?
  next_step = num_occur(array.drop(1), target)
  
  if array.first == target
    1 + next_step
  else
    next_step
  end
end


#Problem 4: You have array of integers. Write a recursive solution to
#determine whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.length <= 1
  return true if array[0] + array[1] == 12
  add_to_twelve?(array.drop(1))
end


#Problem 5: You have array of integers. Write a recursive solution to
#determine if the array is sorted.

def sorted?(array)
  return [] if array.empty?
  return true if array.length == 1
  return false if array[0] > array[1]
  sorted?(array.drop(1))
end


#Problem 6: Write the code to give the value of a number after it is
#reversed. Must use recursion. (Don't use any #reverse methods!)

def reverse(number)
  return number if number < 10
  array = number.to_s.split(//)

  test_number = array.first.to_i
  new_array = array.drop(1)

  new_number = reverse(new_array.join.to_i)
  new_number * 10 + test_number
end

def reverse(number)
  return number if number < 10
  last_digit = number % 10
  previous_digits = number / 10
  "#{last_digit}#{reverse(previous_digits)}".to_i
end

def reverse(number)
  
end