class ApplicationController < ActionController::Base
  def current_player
    User.find(session[:user_id]).player
  end

  def current_user
    User.find(session[:user_id])
  end
end
