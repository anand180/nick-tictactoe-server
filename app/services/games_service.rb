module GamesService

  def self.create(:player_id)
    x_first = _is_x_first?
    game = Game.new(:x_player_id => player_id, :x_first => x_first)

    game.save.tap do |success|
      OpenStruct.new(:success? => success, :game => game)
    end
  end

  private

  def _is_x_first?
    [true,false].sample
  end

end
