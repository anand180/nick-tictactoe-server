class UserCreator
  def self.create_user(email)
    User.create(email: email, password: 'test')
  end
end
