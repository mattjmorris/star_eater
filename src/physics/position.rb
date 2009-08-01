require File.dirname(__FILE__) + "/two_tuple"

class Position < TwoTuple

  def within_diameter?(diameter, other)
    distance(other) < diameter
  end

  def distance(other)
    Math.sqrt((self.x - other.x)**2 + (self.y - other.y)**2)
  end

  def get_vector_to(other)
    return Vector.new(other.x - self.x, other.y - self.y)
  end

  def move(velocity)
    return Position.new(self.x + velocity.x, self.y + velocity.y)  
  end

  def to_s
    return "x => #{@x}, y => #{@y}"
  end

  def ==(other)
    (other && other.x && other.y) ? self.x == other.x && self.y == other.y : false
  end
end