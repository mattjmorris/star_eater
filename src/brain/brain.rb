require File.dirname(__FILE__) + "/../policy/policy"

class Brain

  def initialize

    @policy = Policy.new

    mtcs = MoveTowardsClosestStar.new
    mtcs.weight = 2
    @policy.add_action(mtcs)

    dn = DoNothing.new
    dn.weight = 1
    @policy.add_action(dn)
    
  end

  def next_velocity(ship)
    # Need to move this out of policy to brain
    velocity = @policy.calc_velocity(ship)
  end  
  
end