class RPNCalculator

  attr_accessor :stack
  
  def initialize
    @stack = []
  end
  
  def push(num)
    stack << num
  end
  
  def value
    stack.last
  end
  
  def plus
    error_check
    stack << stack.pop + stack.pop
  end
  
  def minus
    error_check
    stack << - stack.pop + stack.pop
  end
  
  def divide
    error_check
    stack << (1.0 / stack.pop) * stack.pop
  end
  
  def times
    error_check
    stack << stack.pop * stack.pop
  end
  
  def error_check
    raise "calculator is empty" if stack.length < 2
  end
  
  def tokens(string)
    operators = ["+", "-", "*", "/"]
    syms = string.split(' ')
    syms.map { |el| operators.include?(el) ? el.to_sym : el.to_i }
  end
  
  def evaluate(string)
    array = tokens(string)
    array.each do |el|
      if el.is_a?(Fixnum)
        push el
      elsif el == :+
        plus
        puts value
      elsif el == :*
        times
        puts value
      elsif el == :-
        minus
        puts value
      else el == :/
        divide
        puts value
      end
    end
    
    
    value
  end
  
  def run
    while true
      puts "Enter a number:"
      prompt
      input = gets.chomp
      if input == 'q'
        break
      end
      
      evaluate(input)
    end
  end
  
  def prompt
    print "-> "
  end
end

if __FILE__ == $PROGRAM_NAME
  filename = ARGV[0]
  string = File.read(filename)
  
  calc = RPNCalculator.new
  calc.evaluate(string)
end