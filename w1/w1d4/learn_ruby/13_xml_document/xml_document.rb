class XmlDocument
  def initialize(should_format = false)
    @should_format = should_format
  end
  
  def method_missing(method_name, *args, &blk)
    method_name = method_name.to_s
    
    tag = "<#{method_name}"
    
    args.each do |hash|
      hash.each do |key, value|
        tag << " #{key}='#{value}'"
      end
    end
    
    unless block_given?
      tag << "/>"
    else
      tag << ">#{blk.call}</#{method_name}>"
    end
    
    # first find all > occurances, replace with >\n
    
    #<hello>\n 0 = indent 0 times
    #<goodbye>\n 1 = indent 1 time
    #<come_back>\n 2 = indent 2 times
    #</come_back>\n 2 = indent 2 times
    #</goodbye>\n 1 = indent 1 time
    #</hello>\n 0 = indent 0 times

    tag
  end
end