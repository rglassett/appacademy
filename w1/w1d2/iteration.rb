def factors(number)
  lower_factors, upper_factors = [], []

  (1..Math.sqrt(number)).each do |i|
    if number % i == 0
      lower_factors << i
      upper_factors.unshift(number / i) unless (number / i) == i
    end
  end

  lower_factors + upper_factors
end

class Array
  def bubble_sort!(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    sorted = false

    until sorted
      sorted = true
      (0...self.length - 1).each do |i|
        if prc.call(self[i], self[i + 1]) == -1
          self[i], self[i + 1] = self[i + 1] , self[i]
          sorted = false
        end
      end
    end

    self
  end

  def bubble_sort(&prc)
    bubble_sort!(&prc)
  end
end

def substrings(word)
  words = []

  for i in (0...word.length)
    for j in (i...word.length)
      words << word[i..j]
    end
  end

  words
end

def subwords(word, dictionary = "dictionary.txt")
  words = File.readlines(dictionary).map(&:chomp)
  substrings(word).select { |sub| words.include?(sub) }
end
