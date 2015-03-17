nums = []
(2..100).each do |a|
  (2..100).each do |b|
    nums << (a ** b)
  end
end
puts nums.uniq.count