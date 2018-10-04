require 'rails_helper'

RSpec.describe MovesController do
  describe "#create" do
    let(:x_user) {User.create(:email => "test1", :password => "test")}
    let(:x_player) {Player.create(:user_id => x_user.id)}
    let(:o_user) {User.create(:email => "test2", :password => "test")}
    let(:o_player) {Player.create(:user_id => o_user.id)}
    let(:game) {GamesService.create_game(x_player.id)}

    before do
      game.update(:o_player_id => o_player.id, :x_first => true)
    end

    it "creates a move" do
      expect do
         post :create, :params => { :move => { :player_id => x_player.id, :game_id => game.id, :position => 0 } }
      end.to change {Move.count}
    end

    it "redirects to game" do
      post :create, :params => { :move => { :player_id => x_player.id, :game_id => game.id, :position => 0 } }
      expect(response).to redirect_to("/games/#{game.id}")
    end
  end
end
