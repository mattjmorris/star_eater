require File.dirname(__FILE__) + "/policy"

class ReinforcementBrain

  def initialize

    @policy = Policy.new
    #@policy.add_action(DoNothing.new)
    @policy.add_action(MoveTowardsClosestStar.new)
    @policy.add_action(MoveAwayClosestStar.new)

  end

  def next_velocity(ship)
    velocity = @policy.calc_velocity(ship)
    velocity
  end

  def deliver_reward(reward)
    @policy.deliver_reward(reward)
  end
  
end