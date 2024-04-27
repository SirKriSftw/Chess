class Player

  def initialize(color)
    color = color.downcase
    color == "white" || color == "black" ? @color = color : color = "NA"
  end

end
