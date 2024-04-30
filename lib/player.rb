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
    #[2, 1] => b3
    "#{(rank + "a".ord).chr}#{file + 1}"
  end

  def notation_to_index(str)
    # a1 => [0, 0] b3 => [2, 1]
    if(str.length != 2)
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

  def take_turn(str)
    #a2 a5 => Moves a2 piece to a5 if possible otherwise return -1
    options = movable_pieces    
    end_pos = nil
    move = str.split(" ")
    while(end_pos == nil)
      choice = nil
      while(choice == nil)
          if(str.length != 5)  
            print "\e[31m#{str} is not valid move notation (sample move: a1 a2)\e[0m\nPlease select a new move: "       
          else  
            start_pos = notation_to_index(move[0])
            #a5 => [0, 4]
            options.each do |piece|
              if(piece.rank == start_pos[1] && piece.file == start_pos[0])
                choice = piece
                break
              else
                choice = nil
              end
            end
            if choice == nil  
              print "\e[31m#{move[0]} is not a valid piece to move\e[0m\nPlease select a new move: "               
            end            
          end
          if choice == nil  
            str = gets.chomp
            move = str.split(" ")
          end          
      end
      piece_moves = choice.get_moves
      possible_end_pos = notation_to_index(move[1])
      if(piece_moves.include?(possible_end_pos))
        end_pos = possible_end_pos
        return end_pos
      else
        print "\e[31m#{move[0]} #{move[1]} is not a valid move\e[0m\nPlease select a new move: "
        str = gets.chomp
        move = str.split(" ")
      end
    end
  end
    
end
