require 'rails_helper'

RSpec.describe UserResult do

  describe '#success?' do
    context 'unsuccessful' do
      let(:unsuccessful_result) { UserResult.new(success: false) }

      it 'returns false' do
        expect(unsuccessful_result.success?).to be false
      end
    end

    context 'successful' do
      let(:successful_result) { UserResult.new(success: true) }

      it 'returns true' do
        expect(successful_result.success?).to be true
      end
    end
  end

  describe '.duplicate_result' do
    let(:duplicate_result) { UserResult.duplicate_result }

    it 'returns a duplicate result' do
      expect(duplicate_result.duplicate?).to be true
    end

    it 'returns a unsuccessful result' do
      expect(duplicate_result.success?).to be false
    end
  end

  describe '.successful_result' do
    let(:successful_result) { UserResult.successful_result }

    it 'return a successful result' do
      expect(successful_result.success?).to be true
    end
  end

  context 'error results' do
    let(:duplicate_result) { UserResult.duplicate_result }

    describe '#duplicate' do
      it 'returns true' do
        expect(duplicate_result.duplicate?).to be true
      end
    end

    describe '#error_message' do
      it 'return a message' do
        expect(duplicate_result.error_message).to eq('This email is already taken')
      end
    end
  end
end
