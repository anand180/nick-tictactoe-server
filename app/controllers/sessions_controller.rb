class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(:email => params[:login][:email].downcase)
    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id
      render :json => { success: true }
    else
      render :json => { success: false }
    end
  end

  def destroy
    session.delete(:user_id)
    render :json => { success: true }
  end

  def _login_params
    params.require(:login).permit(:email, :password)
  end
end
