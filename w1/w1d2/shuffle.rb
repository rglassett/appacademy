def shuffle_file
  array = []
  print "Enter filename: "
  filename = gets.chomp
  File.foreach(filename) do |line|
    array << line
  end
  array.shuffle!
  
  File.open("#{filename.gsub('.txt','')}-shuffled.txt", "w") do |file|
    array.each do |line|
      file.puts line
    end
  end
end

shuffle_file