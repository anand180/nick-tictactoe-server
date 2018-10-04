require 'rails_helper'

RSpec.describe GamesController do
  let(:player) {UserCreator.create_user_and_player("place_holder")}
  let(:unready_game) {GameCreator.create_unready_game}
  let(:ready_game) {GameCreator.create_ready_game}

  describe "#create" do
  end

  describe "#update" do
    before do
      session[:user_id] = player.user_id
      put :update, :params => {:id => unready_game.id}
    end

    it "adds an O player" do
      expect(unready_game.reload.ready?).to be true
    end

    it "redirects to index" do
      expect(response).to be_redirect
    end
  end

  describe "#show" do
    before do
      session[:user_id] = ready_game.x_player.user_id
      get :show, :params => {:id => ready_game.id}
    end

    it "returns ok status" do
      expect(response).to have_http_status(:ok)
    end

    it "calls GamesService" do
      expect_any_instance_of(GamesService).to receive(:generate_game_state).with(ready_game.id).once.and_call_original
    end
  end

  describe "index" do
  end
end
