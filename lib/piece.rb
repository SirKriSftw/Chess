class Piece
  def to_s
    "#{@color} #{@type}"
  end
end

class Pawn < Piece
  def initialize(color)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : color = "NA"
    @type = "pawn"
  end
end

class Rook < Piece
  def initialize(color)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : color = "NA"
    @type = "pawn"
  end
end

class Knight < Piece
  def initialize(color)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : color = "NA"
    @type = "pawn"
  end
end

class Bishop < Piece
  def initialize(color)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : color = "NA"
    @type = "pawn"
  end
end

class Queen < Piece
  def initialize(color)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : color = "NA"
    @type = "pawn"
  end
end

class King < Piece
  def initialize(color)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : color = "NA"
    @type = "pawn"
  end
end
