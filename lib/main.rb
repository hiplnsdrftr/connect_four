require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/game_turn'

x_player = Player.new
o_player = Player.new

board = Board.new
x_player.game_piece = "X"
o_player.game_piece = "O"

until x_player.name != o_player.name && x_player.name != nil do
  puts "X player, please enter your name: "
  x_player.name = gets.chomp
end

until o_player.name != x_player.name && o_player.name != nil do
  puts "O player, please enter your name: "
  o_player.name = gets.chomp
end

players = [x_player, o_player].shuffle
turn_index = 0
valid_columns = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]

while board.empty_spaces? && !board.winner?(x_player.game_piece) && !board.winner?(o_player.game_piece)
  puts "\n" + board.print

  puts "\nIt is #{players[turn_index].name}'s turn."

  print "What column do you want to play?"
  column = gets.chomp.upcase

  while !valid_columns.include?(column)
    puts "Invalid selection, please select a valid column"
    column = gets.chomp.upcase
  end

  board.add_turn(players[turn_index].game_piece, column)

  while board.row_index < 0
    puts "That column is full, please select another column"
    column = gets.chomp.upcase
    board.add_turn(players[turn_index].game_piece, column)
  end

  if board.winner?(players[turn_index].game_piece)
    puts board.print
    puts "\n#{players[turn_index].name} wins!"

    input = nil

    while input != "y" && input != "n"
      puts "\nDo you want to play again? (y/n)"
      input = gets.chomp.downcase
    end

    if input == "y"
      board = Board.new
    end
  end

  if !board.empty_spaces?
    puts board.print
    puts "\nThis match has ended in a stalemate."

    input = nil

    while input != "y" && input != "n"
      puts "\nDo you want to play again? (y/n)"
      input = gets.chomp.downcase
    end

    if input == "y"
      board = Board.new
    end
  end

  turn_index = turn_index == 0 ? 1: 0
end
