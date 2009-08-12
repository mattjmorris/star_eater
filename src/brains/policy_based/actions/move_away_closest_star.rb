require File.dirname(__FILE__) + "/action"
require File.dirname(__FILE__) + "/../../../../src/physics/velocity"
require File.dirname(__FILE__) + "/../../../../src/physics/position"

class MoveAwayClosestStar
  include Action

  def initialize
    super(self.class.to_s)
  end

  def calc_velocity(ship)

    closest_star_id, closest_star_position = (ship.star_position_hash.sort{|a, b| ship.position.distance(a[1]) <=> ship.position.distance(b[1])}).first

    velocity = nil

    # if there is a closest start, move away from it, otherwise sit still and wait.
    if closest_star_position
      @velocity = Velocity.new_with_xy(0,0) - Velocity.new(ship.position.get_vector_to(closest_star_position))
      $GAME_INFO[:action_info] = "#{self.class} has found closest star to be star id #{closest_star_id} and has set velocity #{velocity} to move away from it, with a weight of #{@weight}"
    else
      @velocity = Velocity.new_with_xy(0, 0)
      $GAME_INFO[:action_info] = "#{self.class} has not found a closest star and has set velocity #{velocity}, with a weight of #{@weight}"
    end

    return @velocity

  end

end