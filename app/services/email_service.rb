module EmailService
  SALT = (('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a).freeze
  ADDRESS = '@gmail.com'.freeze

  def self.generate_email(num = Random.rand(10..26))
    Array.new(num) { SALT.sample }.join << ADDRESS
  end
end
