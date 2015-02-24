require_relative 'piece'


class SlidingPiece < Piece


    def valid_moves(pos)
      x, y = pos
      get_diffs.map do |offset|
        dx, dy = offset
        [dx + x, dy + y]
      end.select { |pos| pos.min.between?(0, 7) && pos.min.between?(0, 7) }
    end

    def directional_diff

    end
end

class Bishop < SlidingPiece
  DIRECTIONAL_DIFFS = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
end
