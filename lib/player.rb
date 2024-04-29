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

  def index_to_notation(file, rank)
    #[4, 1] => b3
    "#{(rank + "a".ord).chr}#{file + 1}"
  end

  def notation_to_index(str)
    # a1 => [0, 0] b3 => [4, 1]
    if(str.length > 2)
      return "ERR"
    end
    arr = str.split("")
    rank = str[0].ord - "a".ord
    file = str[1].to_i - 1
    return [file, rank]
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
