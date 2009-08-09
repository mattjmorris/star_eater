require File.dirname(__FILE__) + "/policies/progressive_exploiter"
#require File.dirname(__FILE__) + "/actions/move_towards_closest_star"
#require File.dirname(__FILE__) + "/actions/do_nothing"

class ReinforcementBrain

  def initialize

    @policy = nil
    #@policy.add_action(DoNothing.new)
    #@policy.add_action(MoveTowardsClosestStar.new)
    ##@policy.add_action(MoveTowardsHighestValueStar.new)
    ##@policy.add_action(GainStarValueKnowledge.new)

    # TODO (MJM) - create environment model class to hold this data over time
    @environment_data = nil

  end

  def set_policy(policy)
    @policy = policy
  end

  def set_data(environment_data, tick_count)
    # (MJM) - note that right now tick_count is ignored.  In future pass to environment model.
    @environment_data = environment_data
  end

  def next_velocity
    velocity = @policy.calc_velocity(@environment_data)
    return velocity
  end

  def deliver_reward(reward)
    @policy.deliver_reward(reward)
  end
  
end