class Piece
  attr_accessor :icon, :color, :board

  def initialize(color, icon, pos = [0,0], board, type)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : @color = "NA"
    color == "white" ? @icon = "\e[37m\e[1m#{icon}\e[22m" : @icon = "\e[30m#{icon}"
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
    if color == "white" then direction = 1 else direction = -1 end
    if color == "white" && @rank == 1 then moves.push([@rank + 2, @file]) end
    if color == "black" && @rank == 1 then moves.push([@rank - 2, @file]) end
    if(@rank + direction <= @@board.length)
      if @@board[@rank + direction][@file] == nil then moves.push([@rank + direction, @file]) end
      if(@file + 1 <= @@board[0].length && @@board[@rank + direction][@file + 1] != nil)
        if @@board[@rank + direction][@file + 1].color != @color then moves.push([@rank + direction, @file + 1]) end
      end
      if(@file - 1 <= @@board[0].length && @@board[@rank + direction][@file - 1] != nil)
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
