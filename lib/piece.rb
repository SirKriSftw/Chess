class Piece
  attr_accessor :icon

  def initialize(color, icon, pos = [0,0], type)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : color = "NA"
    color == "white" ? @icon = "\e[37m\e[1m#{icon}\e[22m" : @icon = "\e[30m#{icon}"
    @rank = pos[0]
    @file = pos[1]
    @type = type
  end
  def to_s
    "#{@color} #{@type} at #{(@rank.ord + "a".ord).chr}#{@file}"
  end
end

class Pawn < Piece
  def initialize(color, pos)
    super(color, "p", pos, "pawn")
  end
end

class Rook < Piece
  def initialize(color, pos)
    super(color, "r", pos, "rook")
  end
end

class Knight < Piece
  def initialize(color, pos)
    super(color, "k", pos, "knight")
  end
end

class Bishop < Piece
  def initialize(color, pos)
    super(color, "b", pos, "bishop")
  end
end

class Queen < Piece
  def initialize(color, pos)
    super(color, "q", pos, "queen")
  end
end

class King < Piece
  def initialize(color, pos)
    super(color, "K", pos, "king")
    color == "white" ? @icon = "\e[37m\e[1m\e[4m#{icon}\e[24m\e[22m" : @icon = "\e[30m\e[4m#{icon}\e[24m\e[22m"
  end
end
