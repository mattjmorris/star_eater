require File.dirname(__FILE__) + "/brain_utility_methods"

class RandomSelectorBrain
  include BrainUtilityMethods

  def initialize
    @target = {}
  end

  def set_data(data, count)
    @data = data
    analyze_new_environment_data
  end

  def next_velocity
    velocity_to(@target[:position])
  end

  private

  def analyze_new_environment_data
    @ship_position = @data[:ship_position]
    process_and_clear_target if reward_given?
    determine_next_target unless @target[:id]
  end

  def determine_next_target
    val = rand(@data[:star_position_hash].length)
    star = @data[:star_position_hash].detect{|x| x if x[0] == val}
    @target = {:id => star[0], :position => star[1], :initial_distance => star_dist(star[1])}
  end

  def process_and_clear_target
    @target = {:id => nil, :position => nil, :initial_distance => nil}
  end

end