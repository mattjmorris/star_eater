require File.dirname(__FILE__) + "/../policy/policy"

class Brain

  def initialize
    @policy = Policy.new
    mtcs = MoveTowardsClosestStar.new
    mtcs.weight = 2
    @policy.add_action(mtcs)
  end

  def next_velocity(ship)
    # Need to move this out of policy to brain
    velocity = @policy.calc_velocity(ship)
  end  
  
end