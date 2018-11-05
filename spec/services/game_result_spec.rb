require 'rails_helper'

RSpec.describe GameResult do
  let(:successful_result) { GameResult.new(success: true) }
  let(:game_full_result) { GameResult.new(success: false, error_type: :game_full) }

  describe '#success?' do
    it 'is successful' do
      expect(successful_result.success?).to be true
    end
  end

  describe '#game_full' do

    it 'returns true' do
      expect(game_full_result.game_full?).to be true
    end

    it 'is unsuccessful' do
      expect(game_full_result.success?).to be false
    end
  end

  describe '#error_message' do
    it 'returns the correct error message' do
      expect(game_full_result.error_message).to eq(GameResult::ERROR_TYPES[:game_full])
    end
  end

  describe '.game_full_result' do
    let(:game_result) { GameResult.game_full_result }

    it 'is unsuccessful' do
      expect(game_result.success?).to be false
    end

    it 'has game_full error_type' do
      expect(game_result.error_type).to eq(:game_full)
    end
  end

  describe '.successful_result' do
    let(:game_result) { GameResult.successful_result }

    it 'is successful' do
      expect(game_result.success?).to be true
    end
  end
end
