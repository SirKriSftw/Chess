class Player

  attr_accessor :pieces, :color

  def initialize(color)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : @color = "NA" 
    @pieces = []
    # Keeps track of king, useful for when checking for check
    @king = nil
  end

  def get_pieces(board)
    board.each do |file|
      file.each do |piece|
        if piece != nil  
          if piece.color == @color 
            @pieces.push(piece)
            if piece.type == "king" then @king = piece end
          end
        end
      end
    end
  end

  def in_check?
    @king.attackers.length > 0
  end

  def checkmate?
    if @king.can_move?  
      p "King can move"
      return false 
    end
    if @king.attackers.length > 1 then return true end
    if can_capture?  
      p "Capture"
      return false 
    end
    if can_block? 
      p "Block"
      return false 
    end
    return true
  end

  def can_capture?
    attacker = @king.attackers[0]
    @pieces.each do |piece|
      if piece.type != "king"
        if piece.get_moves.include?([attacker.file, attacker.rank]) 
          p piece
          return true 
        end
      end
    end
    return false
  end

  def can_block?
    attacker = @king.attackers[0]
    # Cannot block a knight or pawn attack
    if attacker.type == "knight" || attacker.type == "pawn" then return false end
    # For all other pieces check for a block
    to_block = find_attack_direction(attacker)
    @pieces.each do |piece|
      possible_moves = piece.get_moves
      to_block.each do |pos|
        if possible_moves.include?(pos) && piece.type != "king" then return true end
      end
    end
    return false
  end

  def find_attack_direction(attacker)
    if attacker.type == "rook" || attacker.type == "queen"
      if(@king.file == attacker.file)
        # King is on same row but to the right of attacker
        if(@king.rank > attacker.rank)
          return attacker.check_right
        else
          return attacker.check_left
        end
      elsif(@king.rank == attacker.rank)
        # King is on same column but king is above attacker
        if(@king.file > attacker.file)
          return attacker.check_up
        else
          return attacker.check_down
        end
      end
    end
    if attacker.type == "bishop" || attacker.type == "queen"
      # Check if king is above or below attacker
      if(@king.file < attacker.file)
        # King is above and to the right of attacker
        if(@king.rank > attacker.rank)
          return attacker.check_up_right
        else
          return attacker.check_up_left
        end
      else
        # King is below attacker and to the right
        if(@king.rank > attacker.rank)
          return attacker.check_down_right
        else
          return attacker.check_down_left
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

  def move_piece(piece, new_pos)
    start_square = [piece.file, piece.rank]
    end_piece = piece.move(new_pos)
    if end_piece == -1
      puts "\e[31mIllegal move, King cannot castle at this moment\e[0m"
      return false
    end
    if in_check?
      puts "\e[31mIllegal move, puts King in check\e[0m"
      piece.set_pos(start_square)
      if end_piece != nil  
        end_piece.set_pos([end_piece.file, end_piece.rank]) 
      else
        Piece.clear_pos(new_pos)
      end
      return false
    else
      if piece.type == "rook" || piece.type == "king" then piece.has_moved = true end
    end
    return true
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
        return move_piece(choice, end_pos)
      else
        print "\e[31m#{move[0]} #{move[1]} is not a valid move\e[0m\nPlease select a new move: "
        str = gets.chomp
        move = str.split(" ")
      end
    end
  end
    
  def clear_en_passant
    @pieces.each do |piece|
      if piece.type == "pawn" then piece.en_passant = false end
    end
  end
end
