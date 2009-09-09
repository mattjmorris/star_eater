class StaticActionBrain
  attr_accessor :action

  def set_data(environment_data, tick_count)
    @environment_data = environment_data
  end

  def next_velocity
    return @action.calc_velocity(@environment_data)
  end

end