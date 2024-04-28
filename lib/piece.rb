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
    current = 1
    moves = []
    # Check down 
    while(@rank + current < @@board.length) do
      if(@@board[@rank + current][@file] == nil) then moves.push([@rank + current, @file]) else break end
      current += 1
    end
    if(@rank + current < @@board.length)
      if(@@board[@rank + current][@file].color != @color)
        moves.push([@rank + current, @file])
      end
    end

    # Check up
    current = 1
    while(@rank - current >= 0) do
      if(@@board[@rank - current][@file] == nil) then moves.push([@rank - current, @file]) else break end      
      current += 1
    end
    if(@rank - current > 0)
      if(@@board[@rank - current][@file].color != @color)
        moves.push([@rank - current, @file])
      end
    end

    # Check right
    current = 1
    while(@file + current < @@board[0].length) do
      if(@@board[@rank][@file + current] == nil) then moves.push([@rank, @file + current]) else break end      
      current += 1
    end
    if(@file + current < @@board[0].length)
      if(@@board[@rank][@file + current].color != @color)
        moves.push([@rank, @file + current])
      end
    end

    # Check left
    current = 1
    while(@file - current >= 0) do
      if(@@board[@rank][@file - current] == nil) then moves.push([@rank, @file - current]) else break end      
      current += 1
    end
    if(@file - current >= 0)
      if(@@board[@rank][@file - current].color != @color)
        moves.push([@rank, @file - current])
      end
    end
    moves
  end
end

class Knight < Piece
  def initialize(color, pos, board)
    super(color, "k", pos, board, "knight")
  end
end

class Bishop < Piece
  def initialize(color, pos, board)
    super(color, "b", pos, board, "bishop")
  end
end

class Queen < Piece
  def initialize(color, pos, board)
    super(color, "q", pos, board, "queen")
  end
end

class King < Piece
  def initialize(color, pos, board)
    super(color, "K", pos, board, "king")
    color == "white" ? @icon = "\e[37m\e[1m\e[4m#{icon}\e[24m\e[22m" : @icon = "\e[30m\e[4m#{icon}\e[24m\e[22m"
  end
end
