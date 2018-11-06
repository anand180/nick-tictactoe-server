class UsersController < ApplicationController
  class UserCreationError < StandardError
    def message
      'An unknown error occured when trying to create a new user'
    end
  end

  def create
    result = UserService.create!(_user_params)
    if result.success?
      render json: { success: true }
    elsif result.duplicate?
      render json: { error: result.error_message }, status: 422
    else
      raise UserCreationError
    end
  end

  private

  def _user_params
    params.require(:signup).permit(:email, :password, :password_confirmation)
  end
end
