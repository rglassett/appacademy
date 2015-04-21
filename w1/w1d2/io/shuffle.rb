def shuffle_file
  array = []
  print "Enter filename: "
  filename = gets.chomp
  shuffled_lines = File.readlines(filename).shuffle

  File.open("#{filename.gsub('.txt','')}-shuffled.txt", "w") do |file|
    shuffled_lines.each { |line| file.puts line }
  end
end
