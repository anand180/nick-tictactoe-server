module PlayerService

  def self.dashboard_game_lists(current_player_id)
    players_games = Game.where(:x_player_id => current_player_id).or(Game.where(:o_player_id => current_player_id))
    joinable_games = Game.where(:o_player_id => nil).where.not(:x_player_id => current_player_id)
    OpenStruct.new(players_games: players_games, joinable_games: joinable_games)
  end
end
