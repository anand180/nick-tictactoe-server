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
    if Game.find(move_params[:game_id]).o_player
      if move_params[:player_id] == _determine_turn(Game.find(move_params[:game_id]))
        Move.create!(move_params)
        _check_win(:game => Game.find(move_params[:game_id]))
      end
    end
  end

  def self.generate_game_state(game_id)
    game = Game.find(game_id)
    GameState.new(:turn_id => _determine_turn(game),
                  :board => Board.new(game.moves))
  end

  private

  def self._is_x_first?
    [true,false].sample
  end

  def self._check_win(game:)
    WinStates::ALL.each do |win_state|
      moves = game.moves.where(:position => win_state)
      if moves.count == 3
        if moves.all? {|move| move.player_id == game.moves.last.player_id}
          game.update!(:completed => true)
        end
      end
    end
  end

  def self._determine_turn(game)
    if game.new_game?
      return game.x_player_id if game.x_first
      return game.o_player_id
    end
    game.moves.last.player_id == game.x_player_id ? game.o_player_id : game.x_player_id
  end
end
