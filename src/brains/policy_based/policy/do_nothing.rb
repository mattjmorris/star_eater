require File.dirname(__FILE__) + "/action"

# Very simply, causes the ship to just sit in place
class DoNothing
  include Action

  def initialize
    super(self.class.to_s)
  end

  def calc_velocity(ship)

    @info = "#{self.class} has set velocity to zero."
    announce_info if $D

    @velocity = Velocity.new_with_xy(0,0)

    return @velocity

  end

end