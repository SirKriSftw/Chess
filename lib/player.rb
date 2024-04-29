require_relative "piece"
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

  def movable_pieces
    pieces_to_move = []
    @pieces.each do |piece|
      if(piece.has_moves?)
        pieces_to_move.push(piece)        
      end
    end
    pieces_to_move
  end

  def take_turn
    counter = 1
    options = movable_pieces
    puts "Player #{@color}, what piece would you like to move?\n"
    options.each_with_index do |piece, index|
      puts "   (#{counter}) #{piece}"
      counter += 1
    end
  end
    
end
