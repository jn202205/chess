require 'colorize'


class Piece
  attr_reader :color
  attr_accessor :pos, :board, :moved

  def initialize(color, pos = nil, board = nil)
    @color = color
    @pos = pos
    @board = board
    @moved = false #TODO: trigger
  end

  def moves
    valid_moves(@pos)
  end

  def moved?
    @moved
  end

end

class Pawn < Piece
end
