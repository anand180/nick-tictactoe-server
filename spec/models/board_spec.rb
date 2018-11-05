require 'rails_helper'

RSpec.describe Board do
  let(:x_player) {UserCreator.create(:email => "test")}
  let(:game)  {GamesService.create_game(x_player.id)}
  let(:board) {Board.new(game.moves)}

  describe "value_at_space" do
    context "board with moves" do
      before do
        Move.create(:player_id => x_player.id, :game_id => game.id, :position => 0)
      end

      it "should have x at TOP_LEFT" do
        expect(board.value_at_space(Board::Spaces::TOP_LEFT)).to eq('x')
      end
    end
  end
end
