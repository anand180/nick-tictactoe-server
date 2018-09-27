class ApplicationController < ActionController::Base
  def current_player
    Player.find(session[:player_id])
  end
end
