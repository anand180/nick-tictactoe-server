class GamesController < ApplicationController

  def index
    result = PlayerService.dashboard_game_lists(current_player.id)
    render :json => { success: true, players_games: result.players_games, joinable_games: result.joinable_games, email: current_user.email }
  end

  def show
    result = GamesService.generate_game_state(game_id: params[:id], current_player_id: current_player.id)
    render :json => { success: true, spaces: result.board, is_turn: result.is_turn }
  end

  def create
    result = GamesService.create_game!(current_player.id)
    if (result.success?)
      render :json => { success: true }
    end
  end

  def update
    result = GamesService.join_game(:player_id => current_player.id, :game_id => params[:id])
    if (result.game_full?)
      render :json => { success: false, error: result.error_message }
    elsif (result.success?)
      render :json => { success: true }
    else
      raise
    end
  end
end
