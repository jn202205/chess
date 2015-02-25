require 'colorize'

class Board


  def initialize
    @grid = Array.new(8) { Array.new(8) }

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
