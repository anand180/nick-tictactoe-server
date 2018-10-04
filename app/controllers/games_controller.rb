class GamesController < ApplicationController

  def index
    @games = Game.where(:o_player_id => nil)
  end

  def show
    @player_id  = current_player.id
    @game_state = GamesService.generate_game_state(params[:id])
  end

  def create
    GamesService.create_game(current_player.id)
    redirect_to action: 'index'
  end

  def update
    GamesService.join_game(:player_id => current_player.id, :game_id => params[:id])
    redirect_to action: 'index'
  end

end
