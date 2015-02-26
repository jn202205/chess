require 'colorize'
require 'byebug'

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
    valid_moves
  end

  def valid_moves
    potential_moves.select do |move|
      duped_board = @board.dup
      duped_board.move!(@pos, move)
      !duped_board.in_check?(@color)
    end
  end

  def moved?
    @moved
  end

end

class Pawn < Piece
end
