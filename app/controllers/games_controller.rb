class GamesController < ApplicationController

  def index
    @games = Game.where(:o_player_id = nil)
  end

  def create
    result = GamesService.create(:player_id => current_player.id)
    if result.success?
      redirect_to :index
    else
      render :new
    end
  end

  def update
    Game.find(params[:game_id]).update!(join_game_params)
  end

  private

  def join_game_params
    params.require(:game).permit(:o_player_id)
  end
end
