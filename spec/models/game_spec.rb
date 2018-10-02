require 'rails_helper'

RSpec.describe Game do
  let(:x_player) {Player.create(:email => "test")}
  let(:game)  {GamesService.create_game(x_player.id)}

  describe "#new_game?" do
    context "game with no moves" do
      it "returns true" do
        expect(game.new_game?).to be true
      end
    end

    context "game with moves" do
      before do
        Move.create!(:player_id => x_player.id, :game_id => game.id, :position => 0)
      end

      it "return false" do
        expect(game.new_game?).to be false
      end
    end
  end
end
