require './board.rb'
require 'yaml'

class MinesweeperGame
  attr_reader :play_time
  
  def initialize
    @board = Board.new
    puts "Would you like to play a new game, or load an old one?"
    print "Type (new/load): "
    choice = gets.chomp.downcase
    if choice == "new"
      play
    else
      load
    end
  end
  
  def play
    puts "You can type 'save' at any time to save the game state."
    until @board.over?
      @board.display
      next_move = choose_tile
      if next_move == "save"
        puts "Game saved!"
        return
      end
    end
    @board.won? ? result = "8-)" : result = ":-("
    puts "Results of game: #{result}"
  end
  
  def choose_tile
    puts "Would you like to flag a point, or reveal a point?"
    print "Example: f[2, 3] to flag, r[2, 3] to reveal: "
    input = gets.chomp
    if input == "save"
      save
      return "save"
    end
    action = input[0]
    coords = parse_input(input)
    tile = @board[*coords]
    if action == "f"
      tile.change_flag
    elsif action == "r"
      tile.reveal
    else
      puts "That input was invalid. Please try again."
      choose_tile
    end 
  end
  
  def load
    loaded_game = YAML::load(File.open("gamestate.txt"))
    loaded_game.play
  end
  
  def save
    File.open("gamestate.txt", "w") do |file|
      file.puts self.to_yaml
    end
  end
  
  def parse_input(string) 
    coord_start = string.index("[")
    coord_end = string.index("]")
    coords = string[coord_start + 1...coord_end]
    final_coords = coords.split(", ")
    final_coords.map { |el| el.to_i }
  end
end

if __FILE__ == $PROGRAM_NAME
  g = MinesweeperGame.new
end