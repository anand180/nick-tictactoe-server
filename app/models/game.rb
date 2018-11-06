class Game < ApplicationRecord
  belongs_to :x_player, class_name: 'Player'
  belongs_to :o_player, class_name: 'Player', optional: true
  has_many :moves

  def new_game?
    moves.count.zero?
  end

  def last_move
    moves.order(:created_at).last
  end

  def ready?
    o_player.present? && x_player.present?
  end

  def turn_player_id
    return x_player_id if new_game? && x_first
    return o_player_id if new_game?
    return o_player_id if last_move.player_id == x_player_id
    x_player_id
  end
end
