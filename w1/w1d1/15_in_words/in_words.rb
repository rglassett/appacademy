class Fixnum
  
  def in_words
    ones = {
      1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four',
      5 => 'five', 6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine',
      10 => "ten", 11 => "eleven", 12 => "twelve", 13 => "thirteen",
      14 => "fourteen", 15 => "fifteen", 16 => "sixteen", 17 => "seventeen",
      18 => "eighteen", 19 => "nineteen"
    }
    
    tens = {
      2 => "twenty", 3 => "thirty", 4 => "forty", 5 => "fifty",
      6 => "sixty", 7 => "seventy", 8 => "eighty", 9 => "ninety"
    }
    
    len = self.to_s.length
    
    if self == 0 
      return 'zero'
    elsif self < 20
      return ones[self]
    elsif self >= 20 && self < 100
      trim_zeros(tens[self / 10] + ' ' + (self % 10).in_words)
    elsif self >= 100 && self < 1000
      trim_zeros((self / 100).in_words + ' hundred ' + (self % 100).in_words)
    elsif len >= 4 && len <= 6
      trim_zeros((self / 1000).in_words + ' thousand ' + (self % 1000).in_words)
    elsif len >= 7 && len <= 9
     trim_zeros( (self / 1000000).in_words + ' million ' + (self % 1000000).in_words)
    elsif len >= 10 && len <= 12
      trim_zeros((self / 10**9).in_words + ' billion ' + (self % 10**9).in_words)
    elsif len >= 13 && len <= 15
      trim_zeros((self / 10**12).in_words + ' trillion ' + (self % 10**12).in_words)
    end
    
  end
end

def trim_zeros(string)
  if string != 'zero'
    string.gsub(' zero', '')
  else
    string
  end
end