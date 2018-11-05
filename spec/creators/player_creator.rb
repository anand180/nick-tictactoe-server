class PlayerCreator

  def create_player
    user = UserCreator.create('test')
    user.create_player
  end
end
