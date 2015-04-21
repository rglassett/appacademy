def super_print(str, options = {})
  defaults = {
    :times => 1,
    :upcase => false,
    :reverse => false
  }

  options = defaults.merge(options)

  if options[:upcase]
    str = str.upcase
  end

  if options[:reverse]
    str = str.reverse
  end

  options[:times].times { print str }
end
