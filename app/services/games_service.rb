class GamesService

  module WinStates
    ALL = [
      [Board::Spaces::TOP_LEFT, Board::Spaces::TOP_MIDDLE, Board::Spaces::TOP_RIGHT],
      [Board::Spaces::MIDDLE_LEFT, Board::Spaces::MIDDLE_MIDDLE, Board::Spaces::MIDDLE_RIGHT],
      [Board::Spaces::BOTTOM_LEFT, Board::Spaces::BOTTOM_MIDDLE, Board::Spaces::BOTTOM_RIGHT],
      [Board::Spaces::TOP_LEFT, Board::Spaces::MIDDLE_LEFT, Board::Spaces::BOTTOM_LEFT],
      [Board::Spaces::MIDDLE_LEFT, Board::Spaces::MIDDLE_MIDDLE, Board::Spaces::BOTTOM_MIDDLE],
      [Board::Spaces::TOP_RIGHT, Board::Spaces::MIDDLE_RIGHT, Board::Spaces::BOTTOM_RIGHT],
      [Board::Spaces::TOP_LEFT, Board::Spaces::MIDDLE_MIDDLE, Board::Spaces::BOTTOM_RIGHT],
      [Board::Spaces::TOP_RIGHT, Board::Spaces::MIDDLE_MIDDLE, Board::Spaces::BOTTOM_LEFT],
  ]
  end

  def self.create_game(player_id)
    x_first = _is_x_first?
    Game.create!(:x_player_id => player_id, :x_first => x_first)
  end

  def self.make_move(move_params)
    game = Game.find(move_params[:game_id])
    return unless game.ready?
    return unless move_params[:player_id] == game.turn_player_id

    Move.create!(move_params)
    _check_win(:game => game)
  end

  def self.generate_game_state(game_id)
    game = Game.find(game_id)
    GameState.new(:turn_id => game.turn_player_id,
                  :board   => Board.new(game.moves))
  end

  private

  def self._is_x_first?
    [true,false].sample
  end

  def self._check_win(game:)
    WinStates::ALL.each do |win_state|
      moves_in_winstate = game.moves.where(:position => win_state)
      return unless moves_in_winstate.count == 3
      return unless moves_in_winstate.all? {|move| move.made_by_last_player?}
      game.update!(:completed => true)
    end
  end
end
