require_relative "player"

class Board
  LENGTH = 8
  WIDTH = 8

  def initialize(length = LENGTH, width = WIDTH)
    @length = length
    @width = width
    @players = [Player.new("white"), Player.new("black")]
    @squares = []
    @length.times do
      @squares.push(Array.new(@width))
    end
  end

  def print_board
    alternate = 1
    @squares.each do |row|
      (row.length).times do
      if alternate == 1 then print "\e[47m     \e[0m" else print "\e[45m     \e[0m" end
      alternate *= -1
      end
      puts ""
      row.each do |piece|
        if(piece != nil)
          if alternate == 1 then print "\e[47m  #{piece.icon}  \e[0m" else print "\e[45m  #{piece.icon}  \e[0m" end
        else
          if alternate == 1 then print "\e[47m     \e[0m" else print "\e[45m     \e[0m" end
        end
      alternate *= -1
      end
      alternate *= -1
      puts ""
    end

  end
end
