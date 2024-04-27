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
    (@length).times do
      print "\t\t"
      (@width/2).times do
        if alternate == 1 then print "\e[47m    \e[45m    \e[0m" else print "\e[45m    \e[47m    \e[0m" end
      end
      puts ""
      print "\t\t"
      (@width/2).times do
        if alternate == 1 then print "\e[47m    \e[45m    \e[0m" else print "\e[45m    \e[47m    \e[0m" end
      end
      alternate *= -1
      puts ""
    end
  end
end
