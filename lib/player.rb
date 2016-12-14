class Player
  attr_accessor :name, :game_piece
  def initialize(name = nil, game_piece = nil)
    @name = name
    @game_piece = game_piece
  end
end
