require 'colorize'

class Board

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def in_check?(color)
    @grid.each do |row|
      row.each do |piece|
        unless piece.nil?
          piece.moves.each do |move|
            if self[move].is_a?(King) && self[move].color == color
              return true
            end
          end
        end
      end
    end

    false
  end

  def move(start_pos, end_pos)
    if self[start_pos].nil?
      raise ArgumentError.new("No piece to move at #{start_pos}!")
    elsif !self[end_pos].nil? && self[start_pos].color == self[end_pos].color
      raise ArgumentError.new("Can't move a piece on top of another")
    elsif !self[start_pos].moves.include?(end_pos)
      raise ArgumentError.new("Invalid move")
    end

    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end

  def dup
    duped_board = Board.new
    @grid.each_with_index do |row, i|
      row.each_with_index do |pos, j|
        unless pos.nil?
          duped_board[[i,j]] = pos.class.new(pos.color, pos.pos, duped_board)
        end
      end
    end
    duped_board
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
    piece.pos = pos unless piece.nil?
    piece.board = self
  end

  def render
    puts "   0  1  2  3  4  5  6  7"
    @grid.each_with_index do |row, index|
      print "#{index} "
      row.each do |pos|
        print pos.nil? ? '|_ ' : '|' + pos.show + ' '
      end
      puts "|"
    end

    nil
  end

end
