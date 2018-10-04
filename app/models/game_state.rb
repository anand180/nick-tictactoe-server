class GameState

  attr_reader :game_id, :turn_id, :board

  def initialize(game_id:, turn_id:, board:)
    @game_id = game_id
    @turn_id = turn_id
    @board = board
  end

end
