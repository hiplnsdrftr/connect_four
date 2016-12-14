require 'spec_helper'
require_relative '../lib/board'
require_relative '../lib/player'

describe Board do
  it "is initialized with 10 rows and 10 columns" do
    board = Board.new
    expect(board.rows.size).to eq(10)
    expect(board.rows[0].size).to eq(10)
  end

  it "prints 10 rows and 10 columns" do
    board = Board.new
    board_printout =
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      " A B C D E F G H I J"

    expect(board.print).to eq(board_printout)
  end

  it "places a player on the board, in the lowest possible row of the column they selected" do
    board = Board.new
    board.add_turn("X", "A")
    board_printout =
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      "|                   | \n" +
      "|X                  | \n" +
      " A B C D E F G H I J"

      expect(board.print).to eq(board_printout)
  end

  it "stacks player game pieces on top of eachother" do

      second_board = Board.new
      second_board.add_turn("O", "H")
      second_board.add_turn("O", "H")
      second_board.add_turn("O", "H")
      second_board.add_turn("O", "H")
      second_board.add_turn("O", "H")
      second_board.add_turn("O", "H")
      second_board.add_turn("O", "H")
      second_board.add_turn("X", "H")
      second_board.add_turn("X", "B")
      second_board.add_turn("X", "B")
      second_board.add_turn("X", "E")

      second_board_printout =
        "|                   | \n" +
        "|                   | \n" +
        "|              X    | \n" +
        "|              O    | \n" +
        "|              O    | \n" +
        "|              O    | \n" +
        "|              O    | \n" +
        "|              O    | \n" +
        "|  X           O    | \n" +
        "|  X     X     O    | \n" +
        " A B C D E F G H I J"

        expect(second_board.print).to eq(second_board_printout)
    end

  it "has empty spaces when born" do
    board = Board.new
    expect(board.empty_spaces?).to eq(true)
  end

  it "has no empty spaces when completely occupied" do
    board = Board.new
    10.times { board.add_turn("X", "A") }
    10.times { board.add_turn("X", "B") }
    10.times { board.add_turn("X", "C") }
    10.times { board.add_turn("X", "D") }
    10.times { board.add_turn("X", "E") }
    10.times { board.add_turn("X", "F") }
    10.times { board.add_turn("X", "G") }
    10.times { board.add_turn("X", "H") }
    10.times { board.add_turn("X", "I") }
    10.times { board.add_turn("X", "J") }

    expect(board.empty_spaces?).to eq(false)
  end

  context 'checking for win conditions' do
    context 'horizontally' do
      it 'has a win if a 4 consecutive spaces in the same row are occupied by one player' do
        winning_board = Board.new
        winning_board.add_turn("X", "A")
        winning_board.add_turn("X", "B")
        winning_board.add_turn("X", "C")

        winning_turn = GameTurn.new(winning_board, "X", 9, 3)
        winning_turn.take!
        expect(winning_turn).to be_winner
        end
      end
      it 'does not have a win if a space is interupted by another player' do
        losing_board = Board.new
        losing_board.add_turn("X", "A")
        losing_board.add_turn("X", "B")
        losing_board.add_turn("O", "C")

        losing_turn = GameTurn.new(losing_board, "X", 9, 3)
        losing_turn.take!
        expect(losing_turn).to_not be_winner

      end
      it 'does not have a win if an unoccupied space is in between the players pieces' do
        losing_board = Board.new
        losing_board.add_turn("X", "A")
        losing_board.add_turn("X", "B")

        losing_turn = GameTurn.new(losing_board, "X", 9, 3)
        losing_turn.take!
        expect(losing_turn).to_not be_winner

      end

      context 'vertically' do
      it 'has a win if 4 consecutive spaces in the same column are occupied by one player' do
        winning_board = Board.new
        winning_board.add_turn("X", "A")
        winning_board.add_turn("X", "A")
        winning_board.add_turn("X", "A")

        winning_turn = GameTurn.new(winning_board, "X", 6, 0)
        winning_turn.take!
        expect(winning_turn).to be_winner

        o_winning_board = Board.new
        o_winning_board.add_turn("X", "A")
        o_winning_board.add_turn("X", "A")
        o_winning_board.add_turn("X", "A")
        o_winning_board.add_turn("O", "A")
        o_winning_board.add_turn("O", "A")
        o_winning_board.add_turn("O", "A")

        o_winning_turn = GameTurn.new(o_winning_board, "O", 3, 0)
        o_winning_turn.take!
        expect(o_winning_turn).to be_winner
      end
      it 'does not have a win if a space is interupted by another player' do
        losing_board = Board.new
        losing_board.add_turn("X", "A")
        losing_board.add_turn("X", "A")
        losing_board.add_turn("X", "A")
        losing_board.add_turn("O", "A")
        losing_turn = GameTurn.new(losing_board, "X", 5, 0)
        losing_turn.take!
        expect(losing_turn).to_not be_winner

      end
    end
  end
end
