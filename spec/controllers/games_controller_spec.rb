require 'rails_helper'

RSpec.describe GamesController do
  let(:user) { UserCreator.create_user }
  let(:unready_game) {GameCreator.create_unready_game}
  let(:ready_game) {GameCreator.create_ready_game}

  describe '#create' do
    before do
      session[:user_id] = user.id
    end

    it 'creates a new game' do
      expect do
        post :create
      end.to change { Game.count }
    end
  end

  describe "#update" do
    before do
      session[:user_id] = user.id
      put :update, :params => {:id => unready_game.id}
    end

    it "adds an O player" do
      expect(unready_game.reload.ready?).to eq(true)
    end

    it 'is successful' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(true)
    end
  end

  describe "#show" do
    let(:game_with_moves) { GameCreator.create_game_with_moves }

    before do
      session[:user_id] = game_with_moves.x_player.user_id
      get :show, :params => {:id => game_with_moves.id, current_player_id: User.find(session[:user_id])}
    end

    it "returns ok status" do
      expect(response).to have_http_status(:ok)
    end

    it 'is successful' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(true)
    end

    it 'contains a board' do
      json = JSON.parse(response.body)
      expect(json['spaces']).to be_an_instance_of(Array)
    end

    it 'it has is_turn and is not x_players turn' do
      json = JSON.parse(response.body)
      expect(json['is_turn']).to eq(false)
    end
  end

  describe "index" do
    before do
      session[:user_id] = user.id
      get :index
    end

    it 'is successful' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(true)
    end

    it 'contains two game lists' do
      json = JSON.parse(response.body)
      expect(json['players_games']).to be_an_instance_of(Array)
      expect(json['joinable_games']).to be_an_instance_of(Array)
    end

    it 'contains an email' do
      json = JSON.parse(response.body)
;     expect(json['email']).to be_present
    end
  end
end
