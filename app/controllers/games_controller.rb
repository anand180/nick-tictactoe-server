class GamesController < ApplicationController

  def index
    @games = Game.where(:o_player_id = nil)
  end

  def show
    @game = Game.find(params[:id])
    @game_state = GamesService.generate_game_state(params[:id])
  end

  def create
    GamesService.create(session[:player_id])
    redirect_to :index
  end

  def update
    Game.find(params[:game_id]).update!(join_game_params)
  end

  private

  def join_game_params
    params.require(:game).permit(:o_player_id)
  end
end
