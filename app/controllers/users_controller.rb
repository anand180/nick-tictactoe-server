class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(_user_params)
    if @user.save
      @user.create_player
      flash[:notice] = "Account created successfully"
      redirect_to login_url
    else
      flash.now.alert = "Account could not be created. Please try again"
      redirect_to :new
    end
  end

  def destroy
  end

  private

  def _user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
