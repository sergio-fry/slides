class Coordinates < Data.define(:x, :y)
  def to_s
    "#{x}, #{y}"
  end
end

class Vector < Coordinates
  def +(other)
    Vector.new(x + other.x, y + other.y)
  end
end
