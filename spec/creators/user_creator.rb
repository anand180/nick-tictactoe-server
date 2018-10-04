class UserCreator

  def self.create_user_and_player(email)
    user = User.create(:email => email, :password => "test")
    user.create_player
  end

end
