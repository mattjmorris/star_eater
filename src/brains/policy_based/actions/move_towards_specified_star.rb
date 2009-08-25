require File.dirname(__FILE__) + "/action"
require File.dirname(__FILE__) + "/../../../physics/velocity"
require File.dirname(__FILE__) + "/../../../physics/position"

# Move towards the star with the specified id.  If that star is not found, move towards closest star.  If there are no
# stars, sit still.
class MoveTowardsSpecifiedStar
  include Action

  def initialize
    super(self.class.to_s)
  end

  def calc_velocity(star_id, environment_data) 

    star_position_hash = environment_data[:star_position_hash]
    ship_position = environment_data[:ship_position]
    id_and_position_of_specified_star = star_position_hash.find{ |a| a[0] == star_id }
    star_position = id_and_position_of_specified_star[1] if id_and_position_of_specified_star 
    velocity = nil

    # if there is a closest start, move towards it, otherwise sit still and wait.
    if star_position
      @velocity = Velocity.new(ship_position.get_vector_to(star_position))
      $GAME_INFO[:action_info] = "#{self.class} has found specified star with id #{star_id} and has set velocity to moves towards it"
    #TODO (MJM) - should just call MoveTowardsClosestStar action instead of redoing logic here.
    else
      closest_star_id, closest_star_position = (star_position_hash.sort{|a, b| ship_position.distance(a[1]) <=> ship_position.distance(b[1])}).first
      if closest_star_position
        @velocity = Velocity.new(ship_position.get_vector_to(closest_star_position))
        $GAME_INFO[:action_info] = "#{self.class} has found closest star to be id #{closest_star_id} and has set velocity to moves towards it"
      else
        @velocity = Velocity.new_with_xy(0, 0)
        $GAME_INFO[:action_info] = "#{self.class} has not found the specified star and is setting velocity to zero."
      end
    end

    return @velocity
  end

end