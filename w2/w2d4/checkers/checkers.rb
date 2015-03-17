# encoding: UTF-8

#NOTE: Use self.(method) with setter methods! Otherwise your method won't know
#if it's setting an instance variable or using the setter.

require_relative 'players'
require_relative 'board'
require 'yaml'

class CheckersGame
  
  attr_accessor :current_player, :board, :player1, :player2
  
  def initialize(player1, player2, size=8)
    @player1, @player2 = player1, player2
    player1.color, player2.color = :white, :black
    @board, @current_player = Board.new(size), player1
  end
  
  def quit
    abort("Goodbye!")
  end
  
  def save
    File.open("checkers_save.yml", "w") do |file|
      file.puts self.to_yaml
    end
    puts "Game saved."
  end
  
  def load
    loaded_game = YAML::load(File.open("checkers_save.yml"))
    self.board = loaded_game.board
    self.player1 = loaded_game.player1
    self.player2 = loaded_game.player2
    self.current_player = loaded_game.current_player
    puts "Game loaded!"
    prompt
  end
  
  def help
    puts
    puts "Available commands are save, load, quit, and help."
    puts "Make single moves like this: b6 c5"
    puts "Make multiple jumps like this: e7 g5 e3"
    puts
  end
  
  def next_player
    self.current_player = (current_player == player1 ? player2 : player1)
  end
  
  def play
    until board.over?
      play_turn
    end
    
    board.display
    puts "#{winner.name} wins!"
  end
  
  def prompt
    system 'clear'
    board.display
    puts "#{current_player.name}'s turn. Enter 'help' for more info."
    sleep(0.2) if current_player.is_a?(ComputerPlayer)
  end
  
  def play_turn
    prompt
    
    begin
      next_moves = current_player.get_moves(self)
      moving_piece, move_seq = next_moves[0], next_moves[1]
      check_move(moving_piece)
      board[moving_piece].perform_moves(move_seq)
    rescue InvalidMoveError => err
      puts err.message
      retry
    end
    
    next_player
  end
  
  def check_move(pos)
    if board[pos].nil?
      raise InvalidMoveError.new("No piece to move!")
    elsif board[pos].color != current_player.color
      raise InvalidMoveError.new("Must move your own color!")
    end
    nil
  end
  
  def winner
    if board.over?
      board.pieces(player1.color).empty? ? player2 : player1
    end
  end
  
end

if __FILE__ == $PROGRAM_NAME
  brad = HumanPlayer.new("Brad")
  janet = HumanPlayer.new("Janet")
  frank = ComputerPlayer.new("Frank N. Furter")
  rocky = ComputerPlayer.new("Rocky")
  game = CheckersGame.new(rocky, frank, 8)
  game.play
end