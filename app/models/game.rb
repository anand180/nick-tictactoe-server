class Game < ApplicationRecord
  belongs_to :x_player, class_name: "Player"
  belongs_to :o_player, class_name: "Player", :optional => true
  has_many :moves

  def new_game?
    moves.count.zero?
  end
end

