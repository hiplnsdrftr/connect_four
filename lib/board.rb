class Board
  attr_accessor :row_index, :col_index

  def initialize(rows_and_columns = 10, row_index = 0, col_index = 0)
    @column_indicators = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    @row_index = row_index
    @col_index = col_index
    @board = []
    rows_and_columns.times do
      row = []
        rows_and_columns.times do
          row << nil
        end
        @board << row
      end
    end

  def rows
    @board
  end

  def print
    board_print = ""
    @board.each_with_index do |row, index|
      spots = []
      row.each do |space|
        if space.nil?
          spots << " "
        else
          spots << space
        end
      end
      board_print << "|" + spots.join(" ") + "|" + " \n"
    end
    board_print << " " + @column_indicators.join(" ")
    board_print
  end

  def add_turn(player, column)
    @col_index = @column_indicators.index(column)
    counter = -2
    col_values = []
    @board.each_with_index do |row, index|
      counter += 1
      col_values << row[@col_index].nil?
      if !row[@col_index].nil?
        @row_index = counter
        @board[@row_index][@col_index] = player
        break
      end
    end
    if !col_values.include?(false)
      @row_index = 9
      @board[@row_index][@col_index] = player
    end
  end

  def empty_spaces?
    @board.each do |row|
      row.each do |space|
        return true if space.nil?
      end
    end
    return false
  end

  def winner?(player)
    horizontal_win?(player) || vertical_win?(player)
  end

  def horizontal_win?(player)
    victory = false
    #check 4 to the right
    victory = true if @col_index <= 6 &&
    @board[@row_index][@col_index +1] == player &&
    @board[@row_index][@col_index +2] == player &&
    @board[@row_index][@col_index +3] == player
    #check 4 to the left
    victory = true if @col_index >= 3 &&
    @board[@row_index][@col_index -1] == player &&
    @board[@row_index][@col_index -2] == player &&
    @board[@row_index][@col_index -3] == player
    #check 2 to the right, 1 to the left
    victory = true if @col_index <= 7 && @col_index >= 1 &&
    @board[@row_index][@col_index +1] == player &&
    @board[@row_index][@col_index +2] == player &&
    @board[@row_index][@col_index -1] == player
    #check 2 to the left, 1 to the right
    victory = true if @col_index <= 8 && @col_index >= 2 &&
    @board[@row_index][@col_index -1] == player &&
    @board[@row_index][@col_index -2] == player &&
    @board[@row_index][@col_index +1] == player

    victory
  end

  def vertical_win?(player)
    victory = false

    victory = true if @row_index <= 6 &&
    @board[@row_index + 1][@col_index] == player &&
    @board[@row_index + 2][@col_index] == player &&
    @board[@row_index + 3][@col_index] == player

    victory
  end

end
