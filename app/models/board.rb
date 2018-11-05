class Board
  module Spaces
    ALL = [
      TOP_LEFT = 0,
      TOP_MIDDLE = 1,
      TOP_RIGHT = 2,
      MIDDLE_LEFT = 3,
      MIDDLE_MIDDLE = 4,
      MIDDLE_RIGHT = 5,
      BOTTOM_LEFT = 6,
      BOTTOM_MIDDLE = 7,
      BOTTOM_RIGHT = 8
    ].freeze
  end

  BLANK_SPACE = ' '.freeze

  attr_reader :state

  def initialize(moves)
    @state = [BLANK_SPACE] * 9
    moves.each do |move|
      @state[move.position] = move.move_type
    end
  end

  def value_at_space(space)
    @state[space]
  end
end
