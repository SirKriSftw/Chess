class Player

  attr_accessor :pieces, :color

  def initialize(color)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : @color = "NA" 
    @pieces = []
  end

  def get_pieces(board)
    board.each do |file|
      file.each do |piece|
        if piece != nil  
          if piece.color == @color then @pieces.push(piece) end
        end
      end
    end
  end

  def take_turn

  end
end
