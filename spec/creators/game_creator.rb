class GameCreator

  def self.create_ready_game
    player_x = UserCreator.create_user.player
    player_o = UserCreator.create_user.player
    game     = Game.create(:x_player_id => player_x.id, :o_player_id => player_o.id, :x_first => true)
  end

  def self.create_unready_game
    player_x = UserCreator.create_user.player
    game     = Game.create(:x_player_id => player_x.id, :x_first => true)
  end

end
