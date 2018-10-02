class Move < ApplicationRecord
  belongs_to :game
  belongs_to :player

  validates_presence_of :player_id, :game_id, :position
  validates :position, uniqueness: { :scope => :game }

  def move_type
    player == game.x_player ? 'x' : 'o'
  end

end
