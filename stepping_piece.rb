require_relative 'piece'


class SteppingPiece < Piece

  def valid_moves(pos)
    x, y = pos
    get_diffs.map do |offset|
      dx, dy = offset
      [dx + x, dy + y]
    end.select { |pos| pos.min.between?(0, 7) && pos.min.between?(0, 7) }
  end

  def get_diffs
    offsets
  end
end

class Knight < SteppingPiece
  attr_reader :offsets

  def initialize(color, pos, board)
    super
    @offsets = [[-2, -1], [-2, 1], [-1, -2], [-1, 2],
             [1, -2], [1, 2], [2, -1], [2, 1]]
  end
end

class King < SteppingPiece
  attr_reader :offsets
  def initialize(color, pos, board)
    super
    @offsets = [[-1, -1], [-1, 0], [-1, 1], [0, -1],
             [0, 1], [1, -1], [1, 0], [1, 1]]
  end

end
