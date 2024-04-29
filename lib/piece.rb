class Piece
  attr_accessor :icon, :color, :board

  def initialize(color, icon, pos = [0,0], board, type)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : @color = "NA"
    @color == "white" ? @icon = "\e[37m\e[1m#{icon}\e[22m" : @icon = "\e[30m#{icon}"
    @rank = pos[0]
    @file = pos[1]
    @type = type
    @@board = board
  end
  def to_s
    "#{@color} #{@type} at #{(@rank.ord + "a".ord).chr}#{@file}"
  end

  def has_moves?
    get_moves != []
  end

  def check_square(rank, file)
    moves = []
    square = @@board[rank][file]
    if(@type == "king" && square == nil)
      moves.push([rank, file])
    elsif(square.color != @color)
      moves.push([rank, file])
    end
    moves
  end

  def check_up
    current = 1
    moves = []
    while(@rank - current > 0 && @type != "king") do
      if(@@board[@rank - current][@file] == nil) then moves.push([@rank - current, @file]) else break end      
      current += 1
    end

    if(@rank - current > 0)
      moves = moves + check_square(@rank - current, @file)
    end
    moves
  end

  def check_down
    current = 1
    moves = []
    while(@rank + current < @@board.length && @type != "king") do
      if(@@board[@rank + current][@file] == nil) then moves.push([@rank + current, @file]) else break end
      current += 1
    end
   
    if(@rank + current < @@board.length)
      moves = moves + check_square(@rank + current, @file)
    end
    moves
  end

  def check_right
    current = 1
    moves = []
    while(@file + current < @@board[0].length && @type != "king") do
      if(@@board[@rank][@file + current] == nil) then moves.push([@rank, @file + current]) else break end      
      current += 1
    end

    if(@file + current < @@board[0].length)
      moves = moves + check_square(@rank, @file + current)
    end
    moves
  end

  def check_left
    current = 1
    moves = []
    while(@file - current > 0 && @type != "king") do
      if(@@board[@rank][@file - current] == nil) then moves.push([@rank, @file - current]) else break end      
      current += 1
    end

    if(@file - current > 0)
      moves = moves + check_square(@rank, @file - current)
    end
    moves
  end

  def check_up_right
    current = 1
    moves = []
    while(@rank - current > 0 && @file + current < @@board[0].length && @type != "king") do
      if(@@board[@rank - current][@file + current] == nil) then moves.push([@rank - current, @file + current]) else break end      
      current += 1
    end
    if(@rank - current > 0 && @file + current < @@board[0].length)
      moves = moves + check_square(@rank - current, @file + current)
    end
    moves
  end

  def check_up_left
    current = 1
    moves = []
    while(@rank - current >= 0 && @file - current >= 0 && @type != "king") do
      if(@@board[@rank - current][@file - current] == nil) then moves.push([@rank - current, @file - current]) else break end      
      current += 1
    end
    if(@rank - current >= 0 && @file - current >= 0)
      moves = moves + check_square(@rank - current, @file - current)
    end
    moves
  end

  def check_down_right
    current = 1
    moves = []
    while(@rank + current < @@board.length && @file + current < @@board.length && @type != "king") do
      if(@@board[@rank + current][@file + current] == nil) then moves.push([@rank + current, @file + current]) else break end      
      current += 1
    end
    if(@rank + current < @@board.length && @file + current < @@board.length)
      moves = moves + check_square(@rank + current, @file + current)
    end
    moves
  end

  def check_down_left
    current = 1
    moves = []
    while(@rank + current < @@board.length && @file - current >= 0 && @type != "king") do
      if(@@board[@rank + current][@file - current] == nil) then moves.push([@rank + current, @file - current]) else break end      
      current += 1
    end
    if(@rank + current < @@board.length && @file - current >= 0)
      moves = moves + check_square(@rank + current, @file - current)
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
    if @color == "white" && @rank == 1 && @@board[2][@file] == nil then moves.push([@rank + 2, @file]) end
    if @color == "black" && @rank == 6 && @@board[5][@file] == nil then moves.push([@rank - 2, @file]) end
      
    if(@rank + direction < @@board.length && @rank + direction >= 0)
      if @@board[@rank + direction][@file] == nil then moves.push([@rank + direction, @file]) end
      if(@file + 1 < @@board[0].length && @@board[@rank + direction][@file + 1] != nil)
        if @@board[@rank + direction][@file + 1].color != @color then moves.push([@rank + direction, @file + 1]) end
      end
      if(@file - 1 >= 0 && @@board[@rank + direction][@file - 1] != nil)
        if @@board[@rank + direction][@file - 1].color != @color then moves.push([@rank + direction, @file - 1]) end
      end
    end
    moves
  end
end

class Rook < Piece
  def initialize(color, pos, board)
    super(color, "r", pos, board, "rook")
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
      if(@rank + up < @@board.length && @file + across < @@board[0].length)
        if(@@board[@rank + up][@file + across] == nil || @@board[@rank + up][@file + across].color != @color) then moves.push([@rank + up, @file + across]) end
      end

      if(@rank + up < @@board.length && @file - across >= 0)
        if(@@board[@rank + up][@file - across] == nil || @@board[@rank + up][@file - across].color != @color) then moves.push([@rank + up, @file - across]) end
      end

      if(@rank - up >= 0 && @file + across < @@board[0].length)
        if(@@board[@rank - up][@file + across] == nil || @@board[@rank - up][@file + across].color != @color) then moves.push([@rank - up, @file + across]) end
      end

      if(@rank - up >= 0 && @file - across >= 0)
        if(@@board[@rank - up][@file - across] == nil || @@board[@rank - up][@file - across].color != @color) then moves.push([@rank - up, @file - across]) end
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
  end

  def get_moves
    check_up + check_down + check_right + check_left + check_up_right + check_up_left + check_down_right + check_down_left
  end
end
