class Array
  def my_transpose
    transposed = []
    each_index do |i|
      column = []
      each do |row|
        column << row[i]
      end
      transposed << column
    end
    transposed
  end

  def my_uniq!
    i, seen = 0, {}
    until i == length
      if seen[self[i]]
        slice!(i)
      else
        seen[self[i]] = true
        i += 1
      end
    end
    self
  end

  def my_uniq
    dup.my_uniq!
  end

  def two_sum
    solution = []
    (0...self.length - 1).each do |i|
      (i + 1...self.length).each do |j|
        if self[i] + self[j] == 0
          solution << [i, j]
        end
      end
    end
    solution
  end
end

class InvalidMoveError < StandardError; end

class TowersOfHanoi
  attr_reader :towers

  def self.build_towers(size = 3)
    [(1..size).to_a, [], []]
  end

  def initialize(towers = nil)
    @towers = towers || self.class.build_towers
  end

  def get_input
    puts "Move from which tower?"
    from = gets.chomp.to_i
    puts "Move to which tower?"
    to = gets.chomp.to_i

    [towers[from], towers[to]]
  end

  def move!(from, to)
    to << from.pop
  end

  def move(from, to)
    raise InvalidMoveError unless valid_move?(from, to)
    move!(from, to)
  end

  def over?
    towers.first.empty? && (towers[1].empty? || towers[2].empty?)
  end

  def play_turn
    render
    from, to = get_input
    move(from, to)
  end

  def render
    towers.each_with_index do |tower, i|
      puts "Tower #{i}: #{tower}"
    end
  end

  def run
    until over?
      begin
        play_turn
      rescue InvalidMoveError
        puts "Invalid move!"
        retry
      end
    end
    puts "You win the game!"
  end

  def valid_move?(from, to)
    return false if from.empty?
    to.empty? || to.last > from.last
  end
end

def stock_picker(array)
  best_dates = []
  best_price = 0

  (0...array.length - 1).each do |i|
    (i + 1...array.length).each do |j|
      if array[j] - array[i] > best_price
        best_dates = [i, j]
        best_price = array[j] - array[i]
      end
    end
  end

  if best_price <= 0
    raise "Don't buy stock, you'll lose money!"
  end

  best_dates
end

if __FILE__ == $PROGRAM_NAME
  g = TowersOfHanoi.new
  g.run
end
