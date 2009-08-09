require File.dirname(__FILE__) + "/action"

# Very simply, causes the ship to just sit in place
class DoNothing
  include Action

  def initialize
    super(self.class.to_s)
  end

  def calc_velocity(environment_data)

    $GAME_INFO[:action_info] = "#{self.class} has has set velocity to zero."

    @velocity = Velocity.new_with_xy(0,0)

    return @velocity

  end

end