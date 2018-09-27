class Game < ApplicationRecord
  belongs_to :x_player, class_name: "Player"
  belongs_to :o_player, class_name: "Player"
end
