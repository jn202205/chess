require 'colorize'
require_relative 'pieces'
require 'byebug'

class Board

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def setup_board
    setup_pawns
    setup_rooks
    setup_bishops
    setup_knights
    setup_queens
    setup_kings

    nil
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
        if self[move].is_a?(King)
          return true
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
    if @grid[x].nil?
      # debugger
    end
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

  # private TODO: place in private after testing

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
    unless piece.nil?
      piece.board = self
      piece.pos = pos
    end
  end

  private

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

  def setup_rooks
    [[0, 0], [0, 7]].each do |pos|
      self[pos] = Rook.new(:blue)
    end

    [[7, 0], [7, 7]].each do |pos|
      self[pos] = Rook.new(:red)
    end
  end

  def setup_bishops
    [[0, 1], [0, 6]].each do |pos|
      self[pos] = Bishop.new(:blue)
    end

    [[7, 1], [7, 6]].each do |pos|
      self[pos] = Bishop.new(:red)
    end
  end

  def setup_knights
    [[0, 2], [0, 5]].each do |pos|
      self[pos] = Knight.new(:blue)
    end

    [[7, 2], [7, 5]].each do |pos|
      self[pos] = Knight.new(:red)
    end
  end

  def setup_queens
    self[[0, 3]] = Queen.new(:blue)

    self[[7, 3]] = Queen.new(:red)
  end

  def setup_kings
    self[[0, 4]] = King.new(:blue)

    self[[7, 4]] = King.new(:red)
  end

end
