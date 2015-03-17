def factors(number)
  factors = []
  
  for i in (1..Math.sqrt(number))
    if number % i == 0
      factors << i
      factors << number / i unless (number / i) == i
    end
  end
  
  factors.sort
end

p factors(144)