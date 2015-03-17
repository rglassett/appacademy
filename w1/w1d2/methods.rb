def rps
  moves = ["Rock", "Paper", "Scissors"]
  # result = ""
  print "Enter move:"
  player_choice = gets.chomp
  
  unless moves.include?(player_choice)
    puts "Invalid move."
  end
  
  computer_choice = moves.sample
  
  if player_choice == computer_choice
    result = "draw"
  elsif ((player_choice == "Paper" && computer_choice == "Rock") ||
        (player_choice == "Scissors" && computer_choice == "Paper")) ||
        (player_choice == "Rock" && computer_choice == "Scissors")
    
    result = "win"
  else
    result = "lose"
  end
    
  puts "#{computer_choice}, #{result}"
end

rps
