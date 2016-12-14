class GameTurn
  attr_reader :board, :player, :col_index

  def initialize(board, player, row_index, col_index)
    @board = board
    @player = player
    @row_index = row_index
    @col_index = col_index
  end

  def take!
    @board.rows[@row_index][@col_index] = @player
  end

  def winner?
    horizontal_win? || vertical_win?
  end

  def horizontal_win?
    victory = false
    #check 4 to the right
    victory = true if @col_index <= 6 &&
    @board.rows[@row_index][@col_index +1] == @player && @board.rows[@row_index][@col_index +2] == @player &&
    @board.rows[@row_index][@col_index +3] == @player
    #check 4 to the left
    victory = true if @col_index >= 3 &&
    @board.rows[@row_index][@col_index -1] == @player && @board.rows[@row_index][@col_index -2] == @player &&
    @board.rows[@row_index][@col_index -3] == @player
    #check 2 to the right, 1 to the left
    victory = true if @col_index <= 7 && @col_index >= 1 &&
    @board.rows[@row_index][@col_index +1] == @player && @board.rows[@row_index][@col_index +2] == @player &&
    @board.rows[@row_index][@col_index -1] == @player
    #check 2 to the left, 1 to the right
    victory = true if @col_index <= 8 && @col_index >= 2 &&
    @board.rows[@row_index][@col_index -1] == @player && @board.rows[@row_index][@col_index -2] == @player &&
    @board.rows[@row_index][@col_index +1] == @player

    victory
  end

  def vertical_win?
    victory = false
    counter = 0

    victory = true if @row_index <= 6 &&
    # @board.rows[@row_index][@col_index] == @player &&
    @board.rows[@row_index + 1][@col_index] == @player &&
    @board.rows[@row_index + 2][@col_index] == @player &&
    @board.rows[@row_index + 3][@col_index] == @player


      # while counter < 3 && @row_indexdo
      #   victory = false if @board.rows[@row_index][@col_index] != @player
      #   counter += 1
      #   @row_index += 1
      # end
    victory
  end

end
