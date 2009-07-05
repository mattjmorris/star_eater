require File.dirname(__FILE__) + "/action"
require File.dirname(__FILE__) + "/../log_it"

# Very simply, causes the ship to just sit in place
class DoNothing
  include Action
  extend LogIt

  def initialize
    super(self.class.to_s)
  end

  def calc_velocity(ship)

    #@info = "Action has set a velocity of 0,0 with a weight of #{@weight}"
    
    # assumes that the default @velocity is (0,0)
    @velocity

  end

  log({:calc_velocity => [:velocity]})
 
end