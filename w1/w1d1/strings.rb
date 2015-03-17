def num_to_s(num, base)
  digits = []
  dictionary = {10 => "A", 11 => "B", 12 => "C", 13 => "D", 14 => "E", 15 => "F" }
  var = 1
  while var < num
    a = (num / var) % base
    if a >= 10
      digits << dictionary[a]
    else
      digits << a
    end
    var *= base
  end
  digits.join.reverse
end

def caeser(string, shift)
  alphabet = ("a".."z").to_a
  cipher = Array.new(alphabet)
  shift.times do
    cipher << cipher.shift
  end
  string.tr(alphabet.join, cipher.join)
end

puts caeser("ryan",3)