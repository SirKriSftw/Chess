class Piece
  def initialize(color, pos = [0,0], type)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : color = "NA"
    @type = type
    @rank = pos[0]
    @file = pos[1]
  end
  def to_s
    "#{@color} #{@type} at #{(@rank.ord + "a".ord).chr}#{@file}"
  end
end

class Pawn < Piece
  def initialize(color, pos)
    super(color, pos, "pawn")
  end
end

class Rook < Piece
  def initialize(color)
    super(color, pos, "rook")
  end
end

class Knight < Piece
  def initialize(color)
    super(color, pos, "knight")
  end
end

class Bishop < Piece
  def initialize(color)
    super(color, pos, "bishop")
  end
end

class Queen < Piece
  def initialize(color)
    super(color, pos, "queen")
  end
end

class King < Piece
  def initialize(color)
    super(color, pos, "king")
  end
end
