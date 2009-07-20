require File.dirname(__FILE__) + "/action"
require File.dirname(__FILE__) + "/../physics/velocity"
require File.dirname(__FILE__) + "/../physics/position"

class MoveTowardsClosestStar
  include Action

  def initialize
    super(self.class.to_s)
  end

  def calc_velocity(ship)

    closest_star_id, closest_star_position = (ship.star_position_hash.sort{|a, b| ship.position.distance(a[1]) <=> ship.position.distance(b[1])}).first

    velocity = nil

    # if there is a closest start, move towards it, otherwise sit still and wait.
    if closest_star_position
      @velocity = Velocity.new(ship.position.get_vector_to(closest_star_position))
      @info = "#{self.class} has found closest star to be id #{closest_star_id} and has set velocity to moves towards it"
    else
      @velocity = Velocity.new_with_xy(0, 0)
      @info = "#{self.class} has not found a closest star and is setting velocity to zero."
    end

    announce_info if $D

    return @velocity
  end

end