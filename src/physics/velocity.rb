require File.dirname(__FILE__) + "/vector"

class Velocity < Vector

  attr_reader :vector, :max_magnitude

  #***************************************************************************************
  # Velocities are designed so that once they are created, their
  # x and y values cannot be changed.  Instead, a new velocity object is created.
  # The velocity object will automatically resize if it is initialized with a vector
  # whose length exceeds max_magnitude
  #***************************************************************************************
  
  def initialize(vector, max_magnitude = nil)
    @vector = vector
    set_max_magnitude(max_magnitude) if max_magnitude
  end

  # TODO - this method lets a ship override resetting based on max magnitude, which is a bug!
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

  # Allows resetting of max magnitude, which will decrease magnitude of vector if necessary
  def set_max_magnitude(max_magnitude)
    @max_magnitude = max_magnitude
    resize_vector if magnitude > @max_magnitude
  end

  def to_s
    magnitude_pretty = sprintf("%.2f", magnitude)
    @vector.to_s + ", magnitude => #{magnitude_pretty}"
  end

  private

  def resize_vector
    unit_vector = @vector / magnitude
    @vector = unit_vector * @max_magnitude
  end
  
end