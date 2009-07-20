require File.dirname(__FILE__) + "/../src/policy/move_towards_closest_star"
require File.dirname(__FILE__) + "/policy/policy"

class Ship

  MAX_SPEED = 20

  attr_accessor :policy, :star_position_hash
  attr_reader :velocity, :position, :diameter, :bank

  def initialize(position, velocity)
    @position = position
    @velocity = velocity
    @diameter = 20
    @bank = 0
    @star_position_hash = {}
    @policy = get_starting_policy
  end

  def tick(star_position_hash)

    @star_position_hash = star_position_hash

    velocity = @policy.calc_velocity(self)

    velocity.set_max_magnitude(MAX_SPEED)

    $GAME_INFO[:ship_velocity] = velocity

    @position = @position.move(velocity)

    $GAME_INFO[:ship_position] = @position

  end

  def deliver_reward(reward, star_id)
    @bank += reward
    $GAME_INFO[:ship_bank] = @bank
  end
  
  private

  def get_starting_policy
    policy = Policy.new
    mtcs = MoveTowardsClosestStar.new
    mtcs.weight = 2
    policy.add_action(mtcs)
    return policy
  end

end