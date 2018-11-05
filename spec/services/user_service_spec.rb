require 'rails_helper'

RSpec.describe UserService do
  describe '.create!' do
    context 'duplicate email' do
      before do
        User.create(email: 'test', password: 'test')
      end

      it 'return a duplicate result' do
        result = UserService.create!(email: 'test', password: 'test')
        expect(result.success?).to be false
        expect(result.duplicate?). to be true
      end
    end

    context 'non duplicate email' do
      it 'returns a successful result' do
        result = UserService.create!(email: 'test', password: 'test')
        expect(result.success?).to be true
      end
    end
  end
end
