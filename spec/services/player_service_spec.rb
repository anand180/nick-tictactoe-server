require 'rails_helper'

RSpec.describe PlayerService do
  let(:player_1) { Player.create }
  let(:player_2) { Player.create }

  describe '.dashboard_game_lists' do
    before do
      Game.create(x_player_id: player_1.id, x_first: true)
      Game.create(x_player_id: player_2.id, x_first: true)
    end

    it 'returns two lists' do
      result = PlayerService.dashboard_game_lists(player_1.id)
      expect(result.players_games).to be_present
      expect(result.joinable_games).to be_present
    end

    it 'returns correct players_games' do
      result = PlayerService.dashboard_game_lists(player_1.id)
      expect(result.players_games.all? { |game| (game.x_player_id == player_1.id || game.o_player_id == player_1.id) }).to be true
    end

    it 'returns correct joinable_games' do
      result = PlayerService.dashboard_game_lists(player_1.id)
      expect(result.joinable_games.all? { |game| (game.x_player_id != player_1.id && game.o_player_id != player_1.id) }).to be true
    end
  end
end
