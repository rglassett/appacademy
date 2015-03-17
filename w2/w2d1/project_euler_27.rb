def longest_streak(limit)
  best_count = 0
  best_product = 0  
  (-limit..limit).each do |a|
    (-limit..limit).each do |b|
      count = consecutive_primes(a, b)
      if count > best_count || count == 80
        best_count = count
        best_product = a * b
      end
    end
  end
  best_product
end

def consecutive_primes(a, b)
  n = 0
  while true
    if is_prime?(quadratic(a, b, n))
      n += 1
    else
      break
    end
  end
  n
end

def quadratic(a, b, n)
  (n**2) + (a * n) + b
end
  
def is_prime?(num)
  return false if num.even? || num <= 0
  num_root = (num ** 0.5).ceil 
  (2..num_root).to_a.each do |int|
    return false if num % int == 0
  end  
  true
end 

if __FILE__ == $PROGRAM_NAME
  p longest_streak(999)
end