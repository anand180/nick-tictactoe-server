class ApplicationController < ActionController::Base
  def current_player
    User.find(session[:user_id]).player
  end
end
