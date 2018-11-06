class GamesService
  module WinStates
    ALL = [
      [Board::Spaces::TOP_LEFT, Board::Spaces::TOP_MIDDLE, Board::Spaces::TOP_RIGHT].freeze,
      [Board::Spaces::MIDDLE_LEFT, Board::Spaces::MIDDLE_MIDDLE, Board::Spaces::MIDDLE_RIGHT].freeze,
      [Board::Spaces::BOTTOM_LEFT, Board::Spaces::BOTTOM_MIDDLE, Board::Spaces::BOTTOM_RIGHT].freeze,
      [Board::Spaces::TOP_LEFT, Board::Spaces::MIDDLE_LEFT, Board::Spaces::BOTTOM_LEFT].freeze,
      [Board::Spaces::MIDDLE_LEFT, Board::Spaces::MIDDLE_MIDDLE, Board::Spaces::BOTTOM_MIDDLE].freeze,
      [Board::Spaces::TOP_RIGHT, Board::Spaces::MIDDLE_RIGHT, Board::Spaces::BOTTOM_RIGHT].freeze,
      [Board::Spaces::TOP_LEFT, Board::Spaces::MIDDLE_MIDDLE, Board::Spaces::BOTTOM_RIGHT].freeze,
      [Board::Spaces::TOP_RIGHT, Board::Spaces::MIDDLE_MIDDLE, Board::Spaces::BOTTOM_LEFT].freeze,
    ].freeze
  end

  def self.create_game!(player_id)
    x_first = _is_x_first?
    Game.create!(x_player_id: player_id, x_first: x_first)
    GameResult.successful_result
  end

  def self.make_move(game_id:, player_id:, position:)
    game = Game.find(game_id)
    return unless game.ready?
    return unless player_id == game.turn_player_id

    Move.create!(game_id: game_id, player_id: player_id, position: position)
    _check_win(game: game)
  end

  def self.generate_game_state(game_id:, current_player_id:)
    game = Game.find(game_id)
    OpenStruct.new(
      board: Board.new(game.moves).state,
      is_turn: (current_player_id == game.turn_player_id)
    )
  end

  def self.join_game(game_id:, player_id:)
    game = Game.find(game_id)
    return GameResult.game_full_result if game.ready?

    game.update(o_player_id: player_id)
    GameResult.successful_result
  end

  private

  def self._is_x_first?
    [true, false].sample
  end
  private_class_method :_is_x_first?

  def self._check_win(game:)
    WinStates::ALL.each do |win_state|
      moves_in_winstate = game.moves.where(position: win_state)
      break unless moves_in_winstate.count == 3
      break unless moves_in_winstate.all?(&:made_by_last_player?)
      game.update!(completed: true)
    end
  end
  private_class_method :_check_win
end
