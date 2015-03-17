def remix(array)
  alcohols = []
  mixers = []
  is_same = true

  array.each do |el|
    alcohols << el[0]
    mixers << el[1]
  end
  
  while is_same
    is_same = false
    result = []
    alcohols.shuffle!
    mixers.shuffle!
  
    for i in (0...array.length)
      new_drink = [alcohols[i], mixers[i]]
      if array.include?(new_drink)
        is_same = true
      end
      result << new_drink
    end
  end
  
  result
  
end

a = [['Gin', 'Tonic'], ['Rum', 'Coke'], ['Scotch', 'Soda']]

p a
p remix(a)