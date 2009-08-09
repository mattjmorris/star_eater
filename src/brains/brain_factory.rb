require File.dirname(__FILE__) + "/policy_based/policies/progressive_exploiter"
require File.dirname(__FILE__) + "/policy_based/reinforcement_brain"

class BrainFactory

  def self.create_brain(brain_type)
    brain_type ||= :reinforcement
    return self.send(brain_type)
  end

  def self.reinforcement
    brain = ReinforcementBrain.new
    policy = ProgressiveExploiter.new
    # TODO (MJM) create actions for moving towards a specific star and add them here
    policy.create_actions([:MoveTowardsClosestStar, :DoNothing])
    brain.set_policy(policy)
    return brain
  end

end