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
    OFFSETS
  end
end

class Knight < SteppingPiece
  OFFSETS = [[-2, -1], [-2, 1], [-1, -2], [-1, 2],
           [1, -2], [1, 2], [2, -1], [2, 1]]

end

class King < SteppingPiece
  OFFSETS = [[-1, -1], [-1, 0], [-1, 1], [0, -1],
             [0, 1], [1, -1], [1, 0], [1, 1]]

end
