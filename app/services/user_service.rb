module UserService

  def self.create!(user_params)
    return UserResult.duplicate_result if duplicate?(user_params[:email])

    user = User.create!(user_params)
    user.create_player
    UserResult.successful_result
  end

  def self.duplicate?(email)
    return User.find_by(email: email).present?
  end
end
