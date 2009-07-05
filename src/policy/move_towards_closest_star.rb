require File.dirname(__FILE__) + "/action"
require File.dirname(__FILE__) + "/../physics/velocity"
require File.dirname(__FILE__) + "/../physics/position"
require File.dirname(__FILE__) + "/../log_it"

class MoveTowardsClosestStar
  include Action
  extend LogIt

  def initialize
    super(self.class.to_s)
  end

  def calc_velocity(ship)

    closest_star_id, closest_star_position = (ship.star_position_hash.sort{|a, b| ship.position.distance(a[1]) <=> ship.position.distance(b[1])}).first

    @velocity = nil

    # if there is a closest start, move towards it, otherwise sit still and wait.
    if closest_star_position
      @velocity = Velocity.new(ship.position.get_vector_to(closest_star_position))
      @info = ": found closest star id #{closest_star_id}"
    else
      @velocity = Velocity.new_with_xy(0, 0)
      @info = ": did not find a closest star"
    end

    #return velocity

  end

  log({:calc_velocity => [:info, :velocity]})

end