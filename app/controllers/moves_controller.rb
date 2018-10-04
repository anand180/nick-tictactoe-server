class MovesController < ApplicationController

  def create
    GamesService.make_move(_move_params)
    redirect_to :controller => 'games', :action => 'show', :id => _move_params[:game_id]
  end

  private

  def _move_params
    params[:move][:player_id] = params[:move][:player_id].to_i
    params.require(:move).permit(:player_id, :game_id, :position).to_h.symbolize_keys
  end
end
