require File.dirname(__FILE__) + "/policy"

class Brain

  def initialize

    @policy = Policy.new

    mtcs = MoveTowardsClosestStar.new
    mtcs.weight = 2
    @policy.add_action(mtcs)

    #dn = DoNothing.new
    #dn.weight = 1
    #@policy.add_action(dn)
    
  end

  def next_velocity(ship)
    velocity = @policy.calc_velocity(ship)
    velocity
  end
  
end