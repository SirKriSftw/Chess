require_relative "player"
require_relative "piece"

class Board
  LENGTH = 8
  WIDTH = 8

  attr_accessor :squares

  def initialize(length = LENGTH, width = WIDTH)
    @length = length
    @width = width
    @players = [Player.new("white"), Player.new("black")]
    @squares = []
    @length.times do
      @squares.push(Array.new(@width))
    end
    init_pieces
  end

  def init_pieces
    @squares[1].each_with_index do |piece, file|
      @squares[1][file] = Pawn.new("white", [1, file], @squares)
    end
    @squares[0][0] = Rook.new("white", [0,0], @squares)
    @squares[0][1] = Knight.new("white", [0,1], @squares)
    @squares[0][2] = Bishop.new("white", [0,2], @squares)
    @squares[0][3] = Queen.new("white", [0,3], @squares)
    @squares[0][4] = King.new("white", [0,4], @squares)
    @squares[0][5] = Bishop.new("white", [0,5], @squares)
    @squares[0][6] = Knight.new("white", [0,6], @squares)
    @squares[0][7] = Rook.new("white", [0,7], @squares)

    @squares[6].each_with_index do |piece, file|
      @squares[6][file] = Pawn.new("black", [6, file], @squares)
    end
    @squares[7][0] = Rook.new("black", [7,0], @squares)
    @squares[7][1] = Knight.new("black", [7,1], @squares)
    @squares[7][2] = Bishop.new("black", [7,2], @squares)
    @squares[7][3] = Queen.new("black", [7,3], @squares)
    @squares[7][4] = King.new("black", [7,4], @squares)
    @squares[7][5] = Bishop.new("black", [7,5], @squares)
    @squares[7][6] = Knight.new("black", [7,6], @squares)
    @squares[7][7] = Rook.new("black", [7,7], @squares)
  end

  def print_board
    alternate = -1
    @squares.each do |row|
      (row.length).times do
      if alternate == 1 then print "\e[43m     \e[0m" else print "\e[45m     \e[0m" end
      alternate *= -1
      end
      puts ""
      row.each do |piece|
        if(piece != nil)
          if alternate == 1 then print "\e[43m  #{piece.icon}  \e[0m" else print "\e[45m  #{piece.icon}  \e[0m" end
        else
          if alternate == 1 then print "\e[43m     \e[0m" else print "\e[45m     \e[0m" end
        end
      alternate *= -1
      end
      alternate *= -1
      puts ""
    end

  end
end
