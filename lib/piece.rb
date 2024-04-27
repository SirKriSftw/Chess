class Piece
  def initialize(color, type)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : color = "NA"
    @type = type
  end
  def to_s
    "#{@color} #{@type}"
  end
end

class Pawn < Piece
  def initialize(color)
    super(color, "pawn")
  end
end

class Rook < Piece
  def initialize(color)
    super(color, "rook")
  end
end

class Knight < Piece
  def initialize(color)
    super(color, "knight")
  end
end

class Bishop < Piece
  def initialize(color)
    super(color, "bishop")
  end
end

class Queen < Piece
  def initialize(color)
    super(color, "queen")
  end
end

class King < Piece
  def initialize(color)
    super(color, "king")
  end
end
