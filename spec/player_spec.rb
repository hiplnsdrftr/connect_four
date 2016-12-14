require 'spec_helper'
require_relative '../lib/player'

describe Player do
  it 'has a writer for @name' do
    player_one = Player.new
    player_one.name = "Bea"
    player_two = Player.new
    player_two.name = "Luke"
    expect(player_one.name).to eq("Bea")
    expect(player_two.name).to eq("Luke")
  end

  it 'has a writer for @game_piece' do
    player_one = Player.new
    player_one.game_piece = "x"
    player_two = Player.new
    player_two.game_piece = "o"
    expect(player_one.game_piece).to eq("x")
    expect(player_two.game_piece).to eq("o")
  end
end
