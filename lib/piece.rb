class Piece
  def initialize(color, icon, pos = [0,0], type)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : color = "NA"
    @icon = icon
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
    super(color, "i", pos, "pawn")
  end
end

class Rook < Piece
  def initialize(color)
    super(color, "r", pos, "rook")
  end
end

class Knight < Piece
  def initialize(color)
    super(color, "k", pos, "knight")
  end
end

class Bishop < Piece
  def initialize(color)
    super(color, "b", pos, "bishop")
  end
end

class Queen < Piece
  def initialize(color)
    super(color, "q", pos, "queen")
  end
end

class King < Piece
  def initialize(color)
    super(color, "K", pos, "king")
  end
end
