require_relative 'board'
require 'colorize'


class Piece
  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, pos, board)
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
