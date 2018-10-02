require 'rails_helper'

RSpec.describe Move do

  let(:player_o) {Player.create!(:email => "2")}
  let(:player_x) {Player.create!(:email => "1")}
  let(:game) {GamesService.create_game(player_x.id)}
  let(:x_move) {Move.create(:player_id => player_x.id, :game_id => game.id, :position => 0)}
  let(:o_move) {Move.create(:player_id => player_o.id, :game_id => game.id, :position => 1)}


  describe "#move_type" do
    it "returns x" do
      expect(x_move.move_type).to eq('x')
    end

    it "returns o" do
      expect(o_move.move_type).to eq('o')
    end
  end
end
