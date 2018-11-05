class GameResult

  ERROR_TYPES = {
    :game_full => 'This game is full'
  }

  def initialize(success:, error_type: nil)
    @success = success
    @error_type = error_type
  end

  def success?
    return @success
  end

  def game_full?
    return true if @error_type == :game_full
  end

  def error_message
    ERROR_TYPES[@error_type]
  end

  def self.game_full_result
    GameResult.new(success: false, error_type: :game_full)
  end

  def self.successful_result
    GameResult.new(success: true)
  end
end
