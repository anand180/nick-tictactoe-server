require 'rails_helper'

RSpec.describe GameCreator do
  describe ".create_game_with_two_players" do
    it "creates a game" do
      expect do
        GameCreator.create_game_with_two_players
      end.to change {Game.count}
    end

    context "ready game created" do
      let(:game) {GameCreator.create_game_with_two_players}

      it "should have both players" do
        expect(game.ready?).to be true
      end

      it "has x going first" do
        expect(game.x_first).to be true
      end
    end
  end

  describe ".create_unready_game" do
    it "creates a game" do
      expect do
        GameCreator.create_game_with_two_players
      end.to change {Game.count}
    end

    context "unready game created" do
      let(:game) {GameCreator.create_unready_game}

      it "only has an x player" do
        expect(game.ready?).to be false
      end

      it "has x going first" do
        expect(game.x_first).to be true
      end
    end
  end
end
