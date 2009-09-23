require File.dirname(__FILE__) + "/policy_based/policies/progressive_exploiter"
require File.dirname(__FILE__) + "/policy_based/policies/simple_action_selection"
require File.dirname(__FILE__) + "/policy_based/actions/move_towards_closest_star"
require File.dirname(__FILE__) + "/policy_based/reinforcement_brain"
require File.dirname(__FILE__) + "/policy_based/genetic_algorithm_brain"
require File.dirname(__FILE__) + "/decision_tree_brain"
require File.dirname(__FILE__) + "/random_selector_brain"
require File.dirname(__FILE__) + "/static_action_brain"
require File.dirname(__FILE__) + "/svd_brain"

# This is the place to set up your brain and inject any objects it needs (such as an instance of a particular policy
# if you are using some form of reinforcement learning brain)
class BrainFactory

  def self.create_brain(params)
    params[:brain_type] ||= :reinforcement
    return self.send(params[:brain_type], params)
  end

  def self.reinforcement(params={})
    brain = ReinforcementBrain.new
    policy = SimpleActionSelection.new
    brain.set_policy(policy)
    return brain
  end

  def self.genetic_algorithm(params={})
    brain = GeneticAlgorithmBrain.new(params)
    policy = SimpleActionSelection.new
    brain.set_policy(policy)
    return brain
  end

  def self.decisiontree(params={})
    brain = DecisionTreeBrain.new
    return brain
  end

  def self.random_selector(params={})
    brain = RandomSelectorBrain.new
    return brain
  end

  def self.static_action_closest_star(params={})
    brain = StaticActionBrain.new
    brain.action = MoveTowardsClosestStar.new
    return brain
  end
  
  def self.singular_value_decomposition(params={})
    brain = SvdBrain.new
    return brain
  end

end