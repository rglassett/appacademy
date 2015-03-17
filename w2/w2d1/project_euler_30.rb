class Fixnum
  def power_sum?(n)
    digits = self.to_s.split(//)
    digits.map! { |digit| digit.to_i ** n }
    digits.inject(&:+) == self
  end
end

maximum = 354294

arr = (1..maximum).to_a
arr.select! { |el| el != 1 && el.power_sum?(5) }

p arr.inject(&:+)