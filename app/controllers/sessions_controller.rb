class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(:email => params[:login][:email].downcase)
    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id
      redirect root, notice: "login successful"
    else
      flash.now.alert = "Incorrect email or password"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "Logged out"
  end
end
