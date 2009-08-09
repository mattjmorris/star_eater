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

    @brain.set_data(environment_data, tick_count)

    velocity = @brain.next_velocity

    velocity.set_max_magnitude(MAX_SPEED)

    $GAME_INFO[:ship_velocity] = velocity

    #@position = @position.move(velocity)

    #$GAME_INFO[:ship_position] = @position

    return velocity

  end

  # should use the environment to determine what stars are out there.  The environment can make this information fuzzier
  # in the future, which would force more work here.
  #def star_position_hash()
  #  stars = @environment.data[:stars]
  #  positions = {}
  #  stars.each_with_index{|star, idx| positions.merge!({idx => star.position}) }
  #  positions
  #end
  #
  #def deliver_reward(reward, star_id)
  #  @bank += reward
  #  $GAME_INFO[:ship_bank] = @bank
  #  @brain.deliver_reward(reward)
  #end
  
end