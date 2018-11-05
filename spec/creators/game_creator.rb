class GameCreator

  def self.create_ready_game
    player_x = Player.create
    player_o = Player.create
    game     = Game.create(:x_player_id => player_x.id, :o_player_id => player_o.id, :x_first => true)
  end

  def self.create_unready_game
    player_x = Player.create
    game     = Game.create(:x_player_id => player_x.id, :x_first => true)
  end

end
