require 'colorize'
require_relative 'pieces'
require 'byebug'

class Board
  BACKPIECES = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def setup_board
    setup_pawns
    setup_backrows
  end

  def pieces
    @grid.flatten.compact
  end

  def color(color)
    pieces.select { |piece| piece.color == color }
  end

  def in_checkmate?(color)
    self.color(color).all? { |piece| piece.moves.empty? }
  end

  def in_check?(color)
    enemies = pieces.select { |piece| piece.color != color }
    enemies.each do |enemy|
      enemy.potential_moves.each do |move|
        return true if self[move].is_a?(King)
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
    move!(start_pos, end_pos)
  end

  def move!(start_pos, end_pos)
    return if start_pos == end_pos

    self[end_pos] = self[start_pos]
    self[end_pos].pos = end_pos
    self[start_pos] = nil
    self[end_pos].moved = true
  end

  def dup
    duped_board = Board.new
    @grid.flatten.compact.each do |piece|
      duped_board[piece.pos] = piece.class.new(piece.color, piece.pos.dup, duped_board)
    end
    duped_board
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
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

  private

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
    unless piece.nil?
      piece.board = self
      piece.pos = pos
    end
  end

  def setup_pawns
    @grid[1].each_with_index do |pawn, index|
      pawn = Pawn.new(:blue)
      self[[1, index]] = pawn
    end

    @grid[6].each_with_index do |pawn, index|
      pawn = Pawn.new(:red)
      self[[6, index]] = pawn
    end
  end
  #

  def setup_backrows
    @grid[0].each_with_index do |piece, index|
      piece = BACKPIECES[index].new(:blue)
      self[[0, index]] = piece
    end

    @grid[7].each_with_index do |piece, index|
      piece = BACKPIECES[index].new(:red)
      self[[7, index]] = piece
    end
  end

end
