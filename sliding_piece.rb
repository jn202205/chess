require_relative 'piece'
require 'byebug'

class SlidingPiece < Piece


  def valid_moves(pos)
    # debugger
    all_valid_moves = []
    get_dirs.each do |direction|
      all_valid_moves += directional_diff(pos, direction)
    end

    all_valid_moves.uniq
  end

  def directional_diff(pos, direction)
    x, y = pos
    dx, dy = direction
    new_pos = x + dx, y + dy

    return [pos] if new_pos.min < 0 || new_pos.max > 7
    [pos] + directional_diff(new_pos, direction)
  end

  def get_dirs
    directions
  end
end

class Bishop < SlidingPiece

  attr_reader :directions
  def initialize(color, pos, board)
    super
    @directions = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  end
end

class Rook < SlidingPiece
  attr_reader :directions
  def initialize(color, pos, board)
    super
    @directions = [[-1, 0], [0, -1], [0, 1], [1, 0]]
  end
end

class Queen < SlidingPiece
  attr_reader :directions
  def initialize(color, pos, board)
    super
    @directions = [[-1, 0], [0, -1], [0, 1], [1, 0], [-1, -1], [-1, 1], [1, -1], [1, 1]]
  end
end
