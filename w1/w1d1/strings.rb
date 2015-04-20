def num_to_s(num, base)
  digits, place = [], 1
  hex_digits = (0..10).to_a + %w(A B C D E F)

  while place < num
    next_val = (num / place) % base
    digits << hex_digits[next_val]
    place *= base
  end

  digits.join.reverse
end

def caesar(string, shift)
  alphabet = ("a".."z").to_a
  cipher = alphabet.rotate(shift)
  string.tr(alphabet.join, cipher.join)
end
