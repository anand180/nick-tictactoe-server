class GameState

  attr_reader :turn_id, :board

  def initialize(turn_id:, board:)
    @turn_id = turn_id
    @board = board
  end

end
