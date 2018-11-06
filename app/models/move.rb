class Move < ApplicationRecord
  belongs_to :game
  belongs_to :player

  validates_presence_of :player_id, :game_id, :position
  validates :position, uniqueness: { scope: :game }

  def move_type
    player == game.x_player ? 'x' : 'o'
  end

  def made_by_last_player?
    player_id == game.moves.order(:created_at).last.player_id
  end
end
