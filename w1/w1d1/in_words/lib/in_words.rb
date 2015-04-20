ONES = {
  0 => 'zero',
  1 => 'one',
  2 => 'two',
  3 => 'three',
  4 => 'four',
  5 => 'five',
  6 => 'six',
  7 => 'seven',
  8 => 'eight',
  9 => 'nine',
  10 => "ten",
  11 => "eleven",
  12 => "twelve",
  13 => "thirteen",
  14 => "fourteen",
  15 => "fifteen",
  16 => "sixteen",
  17 => "seventeen",
  18 => "eighteen",
  19 => "nineteen"
}

TENS = {
  2 => "twenty",
  3 => "thirty",
  4 => "forty",
  5 => "fifty",
  6 => "sixty",
  7 => "seventy",
  8 => "eighty",
  9 => "ninety"
}

LARGE_NUMBERS = {
  100 => "hundred",
  1000 => "thousand",
  1000000 => "million",
  1000000000 => "billion",
  1000000000000 => "trillion"
}

class Fixnum
  def in_words
    if self < 20
      ONES[self]
    elsif self < 100
      tens_word = TENS[self / 10]
      ones_value = self % 10
      if ones_value == 0
        tens_word
      else
        "#{tens_word} #{ONES[ones_value]}"
      end
    else
      magnitude = self.find_magnitude
      num_mags = self / magnitude
      mag_words = "#{num_mags.in_words} #{LARGE_NUMBERS[magnitude]}"
      remainder = self % magnitude
      if remainder == 0
        mag_words
      else
        "#{mag_words} #{remainder.in_words}"
      end
    end
  end

  def find_magnitude
    mags = LARGE_NUMBERS.keys.select { |key| key <= self }
    mags.max
  end
end
