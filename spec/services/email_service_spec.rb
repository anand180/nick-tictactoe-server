require 'rails_helper'

RSpec.describe EmailService do
  describe '.generate_email' do
    it 'creates an email that ends in @gmail.com' do
      email = EmailService.generate_email
      expect(email.end_with?('@gmail.com')).to be true
    end

    it 'is the right length' do
      email = EmailService.generate_email(26)
      expect(email.length).to eq(36)
    end
  end
end
