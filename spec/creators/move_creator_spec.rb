require 'rails_helper'

RSpec.describe MoveCreator do
  let(:ready_game) { GameCreator.create_ready_game }

  describe '.add_three_non_winning_moves' do
    it 'creates three moves on a ready game' do
      MoveCreator.add_three_non_winning_moves(game: ready_game)
      binding.pry
      expect(ready_game.moves.count).to eq(3)
    end
  end
end
