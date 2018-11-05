class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def current_player
    User.find(session[:user_id]).player
  end

  def current_user
    User.find(session[:user_id])
  end
end
