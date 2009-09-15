class ReinforcementBrain

  def initialize
    @policy = nil
    @environment_data = nil # TODO (MJM) - create environment model class to hold this data over time
  end

  def set_policy(policy)
    @policy = policy
  end

  def set_data(environment_data, tick_count)
    # (MJM) - note that right now tick_count is ignored.  In future pass to environment model.
    @environment_data = environment_data
    if @environment_data[:star_id_delivering_reward]
      @policy.deliver_reward(@environment_data)
      @policy.update_target(@environment_data)
    end

  end

  def next_velocity
    velocity = @policy.calc_velocity(@environment_data)
    return velocity
  end
  
end