class Player < ApplicationRecord
  has_many :games
  validates :email, presence: true
end
