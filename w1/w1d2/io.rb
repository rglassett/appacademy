def guessing_game
  target = rand(1..100)
  guesses = 0
 
  while true
     print "Enter a number: "
     guess = gets.chomp.to_i
     guesses += 1
      
     if guess == target
       puts "Congratulations, you won in #{guesses} tries!"
       break
     elsif guess > target
       puts "Too high!"
     else
       puts "Too low!"
     end
   end
end


if __FILE__ == $PROGRAM_NAME
  guessing_game 
end