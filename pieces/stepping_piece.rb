require_relative 'piece'


class SteppingPiece < Piece

  def potential_moves
    x, y = pos
    reachable_moves = get_diffs.map do |offset|
      dx, dy = offset
      [dx + x, dy + y]
    end.select { |pos| pos.min.between?(0, 7) && pos.min.between?(0, 7) }

    reachable_moves.select {|pos| @board[pos].nil? || @board[pos].color != @color}
  end

  def get_diffs
    offsets
  end
end

class Knight < SteppingPiece
  attr_reader :offsets

  def initialize(color, pos = nil, board = nil)
    super
    @offsets = [[-2, -1], [-2, 1], [-1, -2], [-1, 2],
             [1, -2], [1, 2], [2, -1], [2, 1]]
  end

  def show
    '♞'.colorize(@color)
  end
end

class King < SteppingPiece
  attr_reader :offsets
  def initialize(color, pos = nil, board = nil)
    super
    @offsets = [[-1, -1], [-1, 0], [-1, 1], [0, -1],
             [0, 1], [1, -1], [1, 0], [1, 1]]
  end

  def show
    '♚'.colorize(@color)
  end

end
