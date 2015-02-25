require_relative 'board'

class Chess
  def initialize
    @board = Board.new
    @board.setup_board
  end

  def play
    until over?
      @board.render
      from, to = user_input
      @board.move(from, to)
    end
  end

  def over?
    @board.in_checkmate?(:blue) || @board.in_checkmate?(:red)
  end

  def user_input
    print "Piece starting position:"
    start_pos = gets.chomp.split(",").map(&:to_i).reverse

    print "Piece ending position:"
    end_pos = gets.chomp.split(",").map(&:to_i).reverse

    [start_pos, end_pos]
  end
end
