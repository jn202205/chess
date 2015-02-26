require_relative 'board'

class InputError < StandardError; end
class WrongTurnError < StandardError; end

class Chess
  def initialize
    @board = Board.new
    @board.setup_board
    @turn = :red
  end

  def play
    until over?
      begin
        @board.render
        from, to = user_input
        check_turn(from, @turn)
        @board.move(from, to)
      rescue WrongTurnError, RuntimeError => e
        puts e.message
        retry
      end

      @turn = ((@turn == :red) ? :blue : :red)
    end

    game_over
  end

  private

  def game_over
    winner = @board.winner?
    if winner
      puts "Congratulations, #{winner.capitalize}!"
    else
      puts "Stalemate!"
    end
    @board.render
  end

  def over?
    checkmate = @board.in_checkmate?(:blue) || @board.in_checkmate?(:red)
    stalemate = @board.in_stalemate?(:blue) || @board.in_stalemate?(:red)
    checkmate || stalemate
  end

  def check_turn(pos, color)
    unless @board[pos].color == color
      raise WrongTurnError.new "Not your turn!"
    end
  end

  def user_input
    begin
      print "Piece starting position:".colorize(@turn)
      start_pos = get_input

      check_input(start_pos)

      print "Piece ending position:".colorize(@turn)
      end_pos = get_input

      check_input(end_pos)

    rescue InputError => e
      puts e.message
      retry
    end
    [start_pos.map(&:to_i), end_pos.map(&:to_i)]
  end

  def get_input
    input = gets.chomp.downcase.split("").reverse
    raise InputError.new("Input must be two characters") if input.length != 2
    input[1] = input[1].ord - 97
    input[0] = 8 - input[0].to_i

    input
  end

  def check_input(input)
    unless input.all? { |el| el.between?(0, 7) }
      raise InputError.new ("Invalid input, must be letter number (i.e. f7)")
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  Chess.new.play
end
