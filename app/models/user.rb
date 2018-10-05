class User < ApplicationRecord
  has_one :player

  has_secure_password
  validates :email, presence: true, uniqueness: true

  def player_id
    player.id
  end
end
