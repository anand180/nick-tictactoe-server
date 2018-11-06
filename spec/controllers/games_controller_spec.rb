require 'rails_helper'

RSpec.describe GamesController do
  let(:user) { UserCreator.create_user("email") }
  let(:unready_game) {GameCreator.create_unready_game}
  let(:ready_game) {GameCreator.create_ready_game}

  describe "#create" do
  end

  describe "#update" do
    before do
      user.create_player
      session[:user_id] = user.id
      put :update, :params => {:id => unready_game.id}
    end

    it "adds an O player" do
      expect(unready_game.reload.ready?).to be true
    end

    it "redirects to index" do
      json = JSON.parse(response.body)
      expect(json['success']).to be true
    end
  end

  describe "#show" do
    before do
      session[:user_id] = ready_game.x_player.user_id
    end

    it "returns ok status" do
      get :show, :params => {:id => ready_game.id}
      expect(response).to have_http_status(:ok)
    end

    it "calls GamesService" do
      expect(GamesService).to receive(:generate_game_state).with(ready_game.id).once.and_call_original
      get :show, :params => {:id => ready_game.id}
    end
  end

  describe "index" do
  end
end
