require 'colorize'

class Board

  def initialize
    @grid = Array.new(8) { Array.new(8) }

    nil
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
    if self[start_pos] == nil
      raise ArgumentError.new("No piece to move at #{start_pos}!")
    elsif self[start_pos].color == self[end_pos].color
      raise ArgumentError.new("Can't move a piece on top of another")
    elsif self[start_pos].moves.include?(end_pos)
      self[end_pos] = self[start_pos]
      self[start_pos] = nil
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def render
    @grid.each do |row|
      row.each do |pos|
        print pos.nil? ? '|_ ' : '|' + pos.show + ' '
      end
      puts "|"
    end

    nil
  end

end
