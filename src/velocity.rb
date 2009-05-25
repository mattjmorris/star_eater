require File.dirname(__FILE__) + "/vector"

class Velocity < Vector

  attr_accessor :max_magnitude
  attr_reader :vector

  #***************************************************************************************
  # Velocities are designed so that once they are created, their
  # x and y values cannot be changed.  Instead, a new velocity object is created.
  # The velocity object will automatically resize if it is initialized with a vector
  # whose length exceeds max_magnitude
  #***************************************************************************************
  
  def initialize(vector, max_magnitude = nil)
    @vector = vector
    @max_magnitude = max_magnitude
    resize_vector if max_magnitude and magnitude > max_magnitude
  end

  def self.new_with_xy(x, y, max_magnitude = nil)
    return self.new(Vector.new(x, y), max_magnitude)
  end

  def x
    @vector.x
  end

  def y
    @vector.y
  end

  def +(other)
    new_vector = @vector + other
    #TODO - what if the vectors have different max_magnitudes?  Throw an exception?  Return the smaller?  Return the first?
    return Velocity.new(new_vector, @max_magnitude)
  end

  def -(other)
    new_vector = @vector - other
    return Velocity.new(new_vector, @max_magnitude)
  end

  def *(scalar)
    new_vector = @vector * scalar
    return Velocity.new(new_vector, @max_magnitude)
  end

  def /(scalar)
    return self if scalar == 0
    new_vector = @vector / scalar
    return Velocity.new(new_vector, @max_magnitude)
  end
  
  def magnitude
    Math.sqrt(self.x**2 + self.y**2)
  end

  private

  def resize_vector
    unit_vector = @vector / magnitude
    @vector = unit_vector * @max_magnitude
  end
  
end