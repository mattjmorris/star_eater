require File.dirname(__FILE__) + "/action"
require File.dirname(__FILE__) + "/../../../physics/velocity"
require File.dirname(__FILE__) + "/../../../physics/position"

class MoveTowardsClosestStar
  include Action

  def initialize
    super(self.class.to_s)
  end

  def calc_velocity(environment_data)

    star_position_hash = environment_data[:star_position_hash]
    ship_position = environment_data[:ship_position]

    closest_star_id, closest_star_position = (star_position_hash.sort{|a, b| ship_position.distance(a[1]) <=> ship_position.distance(b[1])}).first

    velocity = nil

    # if there is a closest start, move towards it, otherwise sit still and wait.
    if closest_star_position
      @velocity = Velocity.new(ship_position.get_vector_to(closest_star_position))
      $GAME_INFO[:action_info] = "#{self.class} has found closest star to be id #{closest_star_id} and has set velocity to moves towards it"
    else
      @velocity = Velocity.new_with_xy(0, 0)
      $GAME_INFO[:action_info] = "#{self.class} has not found a closest star and is setting velocity to zero."
    end

    return @velocity
  end

end