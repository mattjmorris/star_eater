class GeneticAlgorithmBrain

  def initialize
    @policy = nil
    @environment_data = nil
  end

  def set_policy(policy)
    @policy = policy
    @policy.exploration_threshold = 0 # don't  explore
    @policy.current_strategy = :exploit
    @policy.estimated_star_values = {0 => 0, 1 => 5, 2 => 10}
  end

  def set_data(environment_data, tick_count)
    @environment_data = environment_data
    if @environment_data[:star_id_delivering_reward]
      # no need to deliver reward, just update which star to go after now that we ate one
      @policy.update_target(@environment_data, tick_count)
    end
  end

  def next_velocity
    velocity = @policy.calc_velocity(@environment_data)
    return velocity
  end
  
end