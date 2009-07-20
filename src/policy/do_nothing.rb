require File.dirname(__FILE__) + "/action"

# Very simply, causes the ship to just sit in place
class DoNothing
  include Action

  def initialize
    super(self.class.to_s)
  end

  def calc_velocity(ship)

    # assumes that the default @velocity is (0,0)
    @velocity

  end

end