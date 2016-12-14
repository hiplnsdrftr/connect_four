require 'spec_helper'

describe GameTurn do
  let(:board) { Board.new }
  let(:player) { Player.new }
  let(:row_index) { 0 }
  let(:col_index) { "A" }
  let(:game_turn) { GameTurn.new(board, player, col_index)}

  it 'has a board' do
    turn = GameTurn.new(board, player, row_index, col_index)
    expect(turn.board).to eq(board)
  end

  it 'has a player' do
    turn = GameTurn.new(board, player, row_index, col_index)
    expect(turn.player).to eq(player)
  end

  it 'has a col index' do
    turn = GameTurn.new(board, player, row_index, col_index)
    expect(turn.col_index).to eq(col_index)
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
