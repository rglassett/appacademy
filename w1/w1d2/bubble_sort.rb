def bubble_sort(array)
  sorted = false
  
  until sorted
    sorted = true
    (0..array.length - 2).each do |i|
      if array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1] , array[i]
        sorted = false
      end
    end
  end
  
  array
end

a = [1]
b = [6, 4, 2, 1]
c = [1, 7, 34, 3, 7]



p a
p bubble_sort(a)
puts

p b
p bubble_sort(b)
puts

p c
p bubble_sort(c)
    