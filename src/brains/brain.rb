# Generic brain that is essentially an abstract or stupid version.
# Note that only mandatory public method is next_velocity

class Brain

  def next_velocity(ship)
    return Velocity.new_with_xy(0, 0)
  end

  
end