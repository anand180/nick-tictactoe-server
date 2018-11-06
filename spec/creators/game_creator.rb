class GameCreator
  def self.create_ready_game
    player_x = UserCreator.create_user.player
    player_o = UserCreator.create_user.player
    Game.create(x_player_id: player_x.id, o_player_id: player_o.id, x_first: true)
  end

  def self.create_unready_game
    player_x = UserCreator.create_user.player
    Game.create(x_player_id: player_x.id, x_first: true)
  end

  def self.create_game_with_moves
    game = GameCreator.create_ready_game
    MoveCreator.add_three_non_winning_moves(game: game)
    game
  end
end
