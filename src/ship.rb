#require 'observer'
require File.dirname(__FILE__) + "/log_it"
require File.dirname(__FILE__) + "/../src/policy/move_towards_closest_star"

class Ship
  #include Observable
  #extend LogIt

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
    #@policy.add_observer(self)
  end

  def tick(position_hash)

    @star_position_hash = position_hash

    velocity = @policy.calc_velocity(self)

    velocity.set_max_magnitude(MAX_SPEED)

    @position = @position.move(velocity)

  end

  def deliver_reward(reward, star_id)
    @bank += reward
    #notify("ship bank is now at #{@bank}")
    $LOGGER.info("ship bank is now at #{bank}") if $D
  end

  # receive notifications from sub-elements and pass on to observers
  #def update(msg)
  #  notify(msg)
  #end
  
  private

  def get_starting_policy
    policy = Policy.new
    mtcs = MoveTowardsClosestStar.new
    mtcs.weight = 2
    policy.add_action(mtcs)
    return policy
  end

  # any time @position changes in the tick method, notify observers
  #log({:tick => [:position]})

  #def notify(msg)
  #  changed
  #  notify_observers(msg, :info)
  #end

end