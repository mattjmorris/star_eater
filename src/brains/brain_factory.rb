require File.dirname(__FILE__) + "/policy_based/policies/progressive_exploiter"
require File.dirname(__FILE__) + "/policy_based/policies/explore_exploit_policy"
require File.dirname(__FILE__) + "/policy_based/actions/move_towards_closest_star"
require File.dirname(__FILE__) + "/policy_based/reinforcement_brain"
require File.dirname(__FILE__) + "/decision_tree_brain"
require File.dirname(__FILE__) + "/static_action_brain"

# This is the place to set up your brain and inject any objects it needs (such as an instance of a particular policy
# if you are using some form of reinforcement learning brain)
class BrainFactory

  def self.create_brain(brain_type)
    brain_type ||= :reinforcement
    return self.send(brain_type)
  end

  def self.reinforcement
    brain = ReinforcementBrain.new
    policy = ExploreExploitPolicy.new
    brain.set_policy(policy)
    return brain
  end

  def self.decisiontree
    brain = DecisionTreeBrain.new
    return brain
  end

  def self.static_action_closest_star
    brain = StaticActionBrain.new
    brain.action = MoveTowardsClosestStar.new
    return brain
  end

  #def self.static_action_random_star
  #  brain = StaticActionBrain.new
  #  brain.action = MoveTowardsRandomStar.new
  #  return brain
  #end
  
end