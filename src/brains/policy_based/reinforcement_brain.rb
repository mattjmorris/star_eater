require File.dirname(__FILE__) + "/policies/policy"
require File.dirname(__FILE__) + "/actions/move_towards_closest_star"
require File.dirname(__FILE__) + "/actions/do_nothing"

class ReinforcementBrain

  def initialize

    @policy = Policy.new
    @policy.add_action(DoNothing.new)
    @policy.add_action(MoveTowardsClosestStar.new)
    #@policy.add_action(MoveTowardsHighestValueStar.new)
    #@policy.add_action(GainStarValueKnowledge.new)

  end

  def next_velocity(ship)
    velocity = @policy.calc_velocity(ship)
    velocity
  end

  def deliver_reward(reward)
    @policy.deliver_reward(reward)
  end
  
end