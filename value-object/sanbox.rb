class Coordinates
  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def ===(other)
    other.x == x && other.y == y
  end
end

puts Position.new(1, 1) == Coordinates.new(1, 1)
# => false
