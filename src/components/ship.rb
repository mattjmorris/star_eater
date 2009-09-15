class Ship

  MAX_SPEED = 20

  attr_reader :velocity, :diameter, :bank #TODO (MJM) - move bank to environment. environment will keep track of how much reward was created as a result of ships actions

  def initialize(brain)
    @brain = brain
    @velocity = Velocity.new_with_xy(0, 0)
    @diameter = 20
    @bank = 0  
  end

  def tick(environment_data, tick_count)

    # add MAX_SPEED to environment_data
    environment_data[:ship_max_speed] = MAX_SPEED

    @brain.set_data(environment_data, tick_count)

    velocity = @brain.next_velocity

    velocity.set_max_magnitude(MAX_SPEED)

    $GAME_INFO[:ship_velocity] = velocity

    return velocity

  end
  
end