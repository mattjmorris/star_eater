require File.dirname(__FILE__) + "/../../src/policy/move_towards_closest_star"
require File.dirname(__FILE__) + "/../brain/brain"

class Ship

  MAX_SPEED = 20

  attr_reader :velocity, :position, :diameter, :bank

  def initialize(brain, position)
    @brain = brain
    @position = position
    @velocity = Velocity.new_with_xy(0, 0)
    @diameter = 20
    @bank = 0
  end

  def tick(environment)

    @environment = environment

    velocity = @brain.next_velocity(self)

    velocity.set_max_magnitude(MAX_SPEED)

    $GAME_INFO[:ship_velocity] = velocity

    @position = @position.move(velocity)

    $GAME_INFO[:ship_position] = @position

    velocity

  end

  # should use the environment to determine what stars are out there.  The environment can make this information fuzzier
  # in the future, which would force more work here.
  def star_position_hash()
    stars = @environment.data[:stars]
    positions = {}
    stars.each_with_index{|star, idx| positions.merge!({idx => star.position}) }
    positions
  end

  def deliver_reward(reward, star_id)
    @bank += reward
    $GAME_INFO[:ship_bank] = @bank
  end
  
end