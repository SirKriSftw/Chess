class Piece
  attr_accessor :icon, :color, :board, :rank, :file, :type, :has_moved

  def initialize(color, icon, pos = [0,0], board, type)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : @color = "NA"
    @color == "white" ? @icon = "\e[37m\e[1m#{icon}\e[22m" : @icon = "\e[30m#{icon}"
    @file = pos[0]
    @rank = pos[1]
    @type = type
    @@board = board
  end

  def to_s
    "#{(@rank + "a".ord).chr}#{@file + 1} #{@type}"
  end

  def move(pos)
    # Keep track of what WAS at the place I am going, in case I need to revert
    temp = @@board[pos[0]][pos[1]] 
    @@board[@file][@rank] = nil
    @@board[pos[0]][pos[1]] = self
    @file = pos[0]
    @rank = pos[1]
    temp
  end

  def set_pos(pos)
    file = pos[0]
    rank = pos[1]

    @@board[file][rank] = self
    @file = pos[0]
    @rank = pos[1]
  end

  def Piece.clear_pos(pos)
    file = pos[0]
    rank = pos[1]

    @@board[file][rank] = nil
  end

  def attackers(my_file = @file, my_rank = @rank)
    attackers_list = []
    temp = @@board[my_file][my_rank]
    @@board[@file][@rank] = nil
    @@board[my_file][my_rank] = self
    temp_file = @file
    temp_rank = @rank
    @file = my_file
    @rank = my_rank

    @@board.each do |file|
      file.each do |piece|
        if(piece != nil)
          if(@color != piece.color)
            if piece.get_moves.include?([my_file, my_rank]) then attackers_list.push(piece) end
          end
        end
      end
    end

    @@board[my_file][my_rank] = temp
    @@board[temp_file][temp_rank] = self
    @file = temp_file
    @rank = temp_rank
    attackers_list
  end

  def has_moves?
    get_moves != []
  end

  def check_square(file, rank)
    moves = []
    square = @@board[file][rank]
    if(@type == "king" && square == nil)
      moves.push([file, rank])
    elsif(square.color != @color)
      moves.push([file, rank])
    end
    moves
  end

  def check_up
    current = 1
    moves = []
    while(@file - current > 0 && @type != "king") do
      if(@@board[@file - current][@rank] == nil) then moves.push([@file - current, @rank]) else break end      
      current += 1
    end

    if(@file - current > 0)
      moves = moves + check_square(@file - current, @rank)
    end
    moves
  end

  def check_down
    current = 1
    moves = []
    while(@file + current < @@board.length && @type != "king") do
      if(@@board[@file + current][@rank] == nil) then moves.push([@file + current, @rank]) else break end
      current += 1
    end
   
    if(@file + current < @@board.length)
      moves = moves + check_square(@file + current, @rank)
    end
    moves
  end

  def check_right
    current = 1
    moves = []
    while(@rank + current < @@board[0].length && @type != "king") do
      if(@@board[@file][@rank + current] == nil) then moves.push([@file, @rank + current]) else break end      
      current += 1
    end

    if(@rank + current < @@board[0].length)
      moves = moves + check_square(@file, @rank + current)
    end
    moves
  end

  def check_left
    current = 1
    moves = []
    while(@rank - current > 0 && @type != "king") do
      if(@@board[@file][@rank - current] == nil) then moves.push([@file, @rank - current]) else break end      
      current += 1
    end

    if(@rank - current > 0)
      moves = moves + check_square(@file, @rank - current)
    end
    moves
  end

  def check_up_right
    current = 1
    moves = []
    while(@file - current > 0 && @rank + current < @@board[0].length && @type != "king") do
      if(@@board[@file - current][@rank + current] == nil) then moves.push([@file - current, @rank + current]) else break end      
      current += 1
    end
    if(@file - current > 0 && @rank + current < @@board[0].length)
      moves = moves + check_square(@file - current, @rank + current)
    end
    moves
  end

  def check_up_left
    current = 1
    moves = []
    while(@file - current >= 0 && @rank - current >= 0 && @type != "king") do
      if(@@board[@file - current][@rank - current] == nil) then moves.push([@file - current, @rank - current]) else break end      
      current += 1
    end
    if(@file - current >= 0 && @rank - current >= 0)
      moves = moves + check_square(@file - current, @rank - current)
    end
    moves
  end

  def check_down_right
    current = 1
    moves = []
    while(@file + current < @@board.length && @rank + current < @@board.length && @type != "king") do
      if(@@board[@file + current][@rank + current] == nil) then moves.push([@file + current, @rank + current]) else break end      
      current += 1
    end
    if(@file + current < @@board.length && @rank + current < @@board.length)
      moves = moves + check_square(@file + current, @rank + current)
    end
    moves
  end

  def check_down_left
    current = 1
    moves = []
    while(@file + current < @@board.length && @rank - current >= 0 && @type != "king") do
      if(@@board[@file + current][@rank - current] == nil) then moves.push([@file + current, @rank - current]) else break end      
      current += 1
    end
    if(@file + current < @@board.length && @rank - current >= 0)
      moves = moves + check_square(@file + current, @rank - current)
    end
    moves
  end

end

class Pawn < Piece
  def initialize(color, pos, board)
    super(color, "p", pos, board, "pawn")    
  end

  def get_moves
    moves = []
    if @color == "white" then direction = 1 else direction = -1 end
    if @color == "white" && @file == 1 && @@board[2][@rank] == nil && @@board[3][@rank] == nil then moves.push([@file + 2, @rank]) end
    if @color == "black" && @file == 6 && @@board[5][@rank] == nil && @@board[4][@rank] == nil then moves.push([@file - 2, @rank]) end
      
    if(@file + direction < @@board.length && @file + direction >= 0)
      if @@board[@file + direction][@rank] == nil then moves.push([@file + direction, @rank]) end
      if(@rank + 1 < @@board[0].length && @@board[@file + direction][@rank + 1] != nil)
        if @@board[@file + direction][@rank + 1].color != @color then moves.push([@file + direction, @rank + 1]) end
      end
      if(@rank - 1 >= 0 && @@board[@file + direction][@rank - 1] != nil)
        if @@board[@file + direction][@rank - 1].color != @color then moves.push([@file + direction, @rank - 1]) end
      end
    end
    moves
  end
end

class Rook < Piece
  def initialize(color, pos, board)
    super(color, "r", pos, board, "rook")
    @has_moved = false
  end

  def get_moves
    check_up + check_down + check_left + check_right
  end
end

class Knight < Piece
  def initialize(color, pos, board)
    super(color, "k", pos, board, "knight")
  end

  def get_moves
    moves = []
    up = 2
    across = 1

    2.times do
      if(@file + up < @@board.length && @rank + across < @@board[0].length)
        if(@@board[@file + up][@rank + across] == nil || @@board[@file + up][@rank + across].color != @color) then moves.push([@file + up, @rank + across]) end
      end

      if(@file + up < @@board.length && @rank - across >= 0)
        if(@@board[@file + up][@rank - across] == nil || @@board[@file + up][@rank - across].color != @color) then moves.push([@file + up, @rank - across]) end
      end

      if(@file - up >= 0 && @rank + across < @@board[0].length)
        if(@@board[@file - up][@rank + across] == nil || @@board[@file - up][@rank + across].color != @color) then moves.push([@file - up, @rank + across]) end
      end

      if(@file - up >= 0 && @rank - across >= 0)
        if(@@board[@file - up][@rank - across] == nil || @@board[@file - up][@rank - across].color != @color) then moves.push([@file - up, @rank - across]) end
      end
      up = 1
      across = 2
      end
    moves
  end
  
end

class Bishop < Piece
  def initialize(color, pos, board)
    super(color, "b", pos, board, "bishop")
  end

  def get_moves
    check_up_right + check_up_left + check_down_right + check_down_left    
  end
end

class Queen < Piece
  def initialize(color, pos, board)
    super(color, "q", pos, board, "queen")
  end

  def get_moves
    check_up + check_down + check_right + check_left + check_up_right + check_up_left + check_down_right + check_down_left
  end
end

class King < Piece
  def initialize(color, pos, board)
    super(color, "K", pos, board, "king")
    color == "white" ? @icon = "\e[37m\e[1m\e[4m#{icon}\e[24m\e[22m" : @icon = "\e[30m\e[4m#{icon}\e[24m\e[22m"
    @has_moved = false
  end

  def get_moves
    moves = check_up + check_down + check_right + check_left + check_up_right + check_up_left + check_down_right + check_down_left
    # Check if castling is a possibility (3 spaces left = nil, 2 spaces right = nil AND following space is a rook that has not moved)
    moves = moves + castling
    moves
  end

  def castling
    moves = []
    # Have not moved AND not in check
    if @has_moved == false
      king_rook = @@board[@file][@rank + 3]
      queen_rook = @@board[@file][@rank - 4]
      if @@board[@file][@rank + 1] == nil && @@board[@file][@rank + 2] == nil && king_rook != nil
        if !king_rook.has_moved then moves.push([@file, @rank + 2]) end
      end
      if @@board[@file][@rank - 1] == nil && @@board[@file][@rank - 2] == nil && @@board[@file][@rank - 3] == nil && queen_rook != nil
        if !queen_rook.has_moved then moves.push([@file, @rank - 2]) end
      end      
    end
    moves
  end

  def can_move?
    moves = get_moves
    moves.each do |new_pos|
      if attackers(new_pos[0], new_pos[1]).length == 0 then return true end
    end
    return false
  end

  def move(pos)
    # If attempting to castle
    if (@rank - pos[1]).abs == 2 && attackers.length == 0
      direction = @rank - pos[1]
      # King side castle
      if direction < 0
        counter = 1
        2.times do 
          if attackers(@file, @rank + counter).length != 0 then return -1 end  
          counter += 1
        end
        king_rook = @@board[@file][@rank + 3]
        king_rook.move([@file, @rank + 1])
      # Queen side castle
      else
        counter = 1
        3.times do 
          if attackers(@file, @rank - counter).length != 0 then return -1 end  
          counter += 1
        end
        queen_rook = @@board[@file][@rank - 4]
        queen_rook.move([@file, @rank - 1])
      end
    end
    super(pos)
  end
end
