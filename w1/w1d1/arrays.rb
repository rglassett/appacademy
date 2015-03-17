class Array
  def my_uniq
    solution = []
    self.each do |x|
      solution << x unless solution.include?(x)
    end
    solution
  end
  
  def two_sum
    solution = []
    (0..self.length - 2).each do |i|
      (i+1..self.length - 1).each do |j|
        if self[i] + self[j] == 0
          solution << [i, j]
        end    
      end
    end
    solution
  end
end

def tower
  tow1 = [4, 3, 2, 1]
  tow2 = []
  tow3 = []
  gameboard = {'1' => tow1, '2' => tow2, '3' => tow3}
  
  while tow2.length < 4 && tow3.length < 4
    print_board(tow1, tow2, tow3)
    puts "What tower do you want to move from?"
    source = gameboard[gets.chomp]
    puts "What tower do you want to send to?"
    destination = gameboard[gets.chomp]
    
    if is_valid?(source, destination)
      destination << source.pop
    else
      puts "Invalid move."
      next
    end     
  end
end

def is_valid? (source, destination)
  return false if source.length == 0
  array = Array.new(destination)
  array << source[-1]
  array == array.sort.reverse
end

def print_board (tow1, tow2, tow3)
  puts tow1.to_s
  puts tow2.to_s
  puts tow3.to_s
end

def my_transpose(matrix)
  final = []
  matrix.each_index do |i|
    column = []
    matrix.each do |row|
      column << row[i]
    end
    final << column
  end
  final   
end

def stock_picker(array)
  best_dates = []
  best_price = 0
  
  (0..array.length - 2).each do |i|
    (i+1..array.length - 1).each do |j|
      if array[j] - array[i] > best_price
        best_dates = [i, j]
        best_price = array[j] - array[i]
      end
    end
  end
  
  if best_price <= 0
    return "Don't buy stock, you'll lose money!"
  end
  
  best_dates
end

puts stock_picker([1, 2, 3, 4, 200])