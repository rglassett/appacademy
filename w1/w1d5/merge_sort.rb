class Array
  def merge_sort 
    return self if count < 2

    middle = count / 2

    left, right = self.take(middle), self.drop(middle)
    sorted_left, sorted_right = left.merge_sort, right.merge_sort

    merge(sorted_left, sorted_right)
  end

  def merge(left, right)
    merged_array = []
    until left.empty? || right.empty?
      merged_array <<
        ((left.first < right.first) ? left.shift : right.shift)
    end

    merged_array + left + right
  end
end

unsorted_array = [5, 2, 6, 7, 9]
# middle = 2
# left = [5, 2]
# right = [6, 7, 9]
# sorted_left = merge(sort([5, 2]))


# merge_sort([5, 2])
# middle = 1
# left = [5]
# right = [2]
# sorted_left = merge_sort([5]) = [5]
# sorted_right = merge_sort([2]) = [2]

# merge([5], [2])