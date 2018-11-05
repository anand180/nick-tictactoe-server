require 'rails_helper'

RSpec.describe GamesService do
  let(:player_o) {Player.create}
  let(:player_x) {Player.create}
  let(:ready_game) {GameCreator.create_ready_game}
  let(:unready_game) {GameCreator.create_unready_game}

  describe ".create_game!" do
    it "creates a new game" do
      expect do
        GamesService.create_game!(player_x.id)
      end.to change {Game.count}
    end

    context "game created" do
      it "game should have correct initial state" do
        game = GameService.create_game!(player_x.id)
        expect(game.x_player_id).to eq(player_x.id)
        expect(game.x_first).to eq(true).or eq(false)
      end
    end
  end

  describe ".make_move" do
    before do
      Move.create(:player_id => player_x.id, :game_id => ready_game.id, :position => 0)
      Move.create(:player_id => player_o.id, :game_id => ready_game.id, :position => 8)
      Move.create(:player_id => player_x.id, :game_id => ready_game.id, :position => 1)
      Move.create(:player_id => player_o.id, :game_id => ready_game.id, :position => 3)
    end

    context "when winning move" do
      before do
        GamesService.make_move({:player_id => player_x.id, :game_id => ready_game.id, :position => 2})
      end

      it "completes the game" do
        expect(ready_game.reload.completed).to be true
      end
    end

    context "when not a winning move" do
      before do
        GamesService.make_move({:player_id => player_x.id, :game_id => ready_game.id, :position => 7})
      end

      it "does not complete the game" do
        expect(ready_game.reload.completed).to be false
      end
    end
  end

  describe ".join_game" do
    let(:player) { Player.create }

    context "unready game" do
      it "adds an O player" do
        GamesService.join_game(:player_id => player.id, :game_id => unready_game.id)
        expect(unready_game.reload.ready?).to be true
      end
    end

    context "ready game" do
      it "is unsuccessful" do
        result = GamesService.join_game(:player_id => player.id, :game_id => ready_game.id)
        expect(result.success?).to be false
      end
    end
  end

  describe ".generate_game_state" do
    let(:result) {GamesService.generate_game_state(game_id: game.id, current_player_id: game.x_player_id)}

    context "game with 0 moves" do
      it "generates a blank board" do
        expect(result.board.all? { |space| space == ' ' }).to be true
      end

      it "is x's turn" do
        expect(result.is_turn).to be true
      end
    end

    context "game with moves" do
      before do
        Move.create(:player_id => ready_game.x_player_id, :game_id => ready_game.id, :position => 0)
        Move.create(:player_id => ready_game.o_player_id, :game_id => ready_game.id, :position => 1)
        Move.create(:player_id => ready_game.x_player_id, :game_id => ready_game.id, :position => 2)
      end

      it "generate a board with filled top row" do
        expect(result.board.value_at_space(Board::Spaces::TOP_LEFT)).to eq('x')
        expect(result.board.value_at_space(Board::Spaces::TOP_MIDDLE)).to eq('o')
        expect(result.board.value_at_space(Board::Spaces::TOP_RIGHT)).to eq('x')
      end

      it "is not x's turn" do
        expect(result.is_turn).to be false
      end
    end
  end
end
