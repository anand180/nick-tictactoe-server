class UserCreator
  def self.create_user
    email = EmailService.generate_email
    user = User.create(email: email, password: 'testtest')
    user.create_player
    user
  end
end
