def super_print(str, options = {})
  defaults = {
    :times => 1,
    :upcase => false,
    :reverse => false
  }
  
  options = defaults.merge(options)
  
  str = str * options[:times]
  
  if options[:upcase]
    str = str.upcase
  end
  if options[:reverse]
    str = str.reverse
  end
  
  print str
end

super_print("Hello")
puts
super_print("Hello", {:upcase => true, :reverse => true})
puts
super_print("Hello", {:times => 3})