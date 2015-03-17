def spiral_count(largest_side)
  spiral_nums = [1]
  side_length = 3
  while side_length <= largest_side
    4.times do
      spiral_nums << spiral_nums[-1] + (side_length - 1)
    end
    side_length += 2
  end
  spiral_nums
end

p spiral_count(1001).inject(&:+)