require File.dirname(__FILE__) + "/two_tuple"

# Simple Representation of a vector
class Vector < TwoTuple

  def +(other)
    new_x = self.x + other.x
    new_y = self.y + other.y
    return Vector.new(new_x, new_y)
  end

  def -(other)
    new_x = self.x - other.x
    new_y = self.y - other.y
    return Vector.new(new_x, new_y)
  end

  def *(scalar)
    new_x = self.x * scalar
    new_y = self.y * scalar
    return Vector.new(new_x, new_y)
  end

  def /(scalar)
    return self if scalar == 0
    new_x = self.x / scalar.to_f
    new_y = self.y / scalar.to_f
    return Vector.new(new_x, new_y)
  end

  def to_s
    "x => #{@x}, y => #{@y}"
  end

end