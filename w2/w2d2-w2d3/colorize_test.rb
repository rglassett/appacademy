require 'colorize'

(0..7).each do |x|
  (0..7).each do |y|
    if [x, y].count(&:odd?) == 1
      print el.colorize(:background => :light_black)
    else
      print el
    end
  end
end