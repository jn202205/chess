require_relative 'piece'

class Pawn < Piece
  def initialize(color, pos, board)
    super
  end

  def valid_moves(pos)
    all_valid_moves = []

    vertical_direction = (@color == :blue) ? 1 : -1

    if can_move_forward?(pos, vertical_direction)
      all_valid_moves << [pos.first, pos.last + vertical_direction]
    end

    if can_attack?
    end

  end

  def can_attack?(vertical_direction)

  end

  def can_move_forward?(pos, vertical_direction)
    x, y = pos
    front = @board[x][y + vertical_direction]
    front.nil? && front[1].between(0, 7)
  end

  def show
    '♟'.colorize(@color)
  end
end
