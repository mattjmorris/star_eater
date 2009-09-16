require File.dirname(__FILE__) + "/../actions/move_towards_specified_star"
require File.dirname(__FILE__) + "/../../../../src/util/extend_array"

# The strategy here is simply to go for the currently highest valued star (when exploiting).  Distance may be included
# in the decision about which star to go to (star_value/distance = action value).
class SimpleActionSelection

  attr_accessor :estimated_star_values, :current_strategy, :incorporate_distance

  def initialize
    @move_towards_specified_star = MoveTowardsSpecifiedStar.new
    @estimated_star_values = {}
    @star_eat_count = {}
    @current_strategy = :explore
    @incorporate_distance = true
    @max_num_stars_seen = 0
    # useful when reward values are static TODO - change to be set by GA?
    @do_one_time_sampling = false
    @exploration_threshold = 0.1
  end

  def calc_velocity(environment_data)
    @max_num_stars_seen = environment_data[:star_position_hash].size if environment_data[:star_position_hash].size > @max_num_stars_seen
    return @move_towards_specified_star.calc_velocity(@id_of_selected_star_to_eat, environment_data)
  end

  def deliver_reward(environment_data)
    reward = environment_data[:reward]
    star_id = environment_data[:star_id_delivering_reward] 
    @star_eat_count[star_id] ||= 0
    @estimated_star_values[star_id] ||= 0
    @star_eat_count[star_id] += 1
    # new estimate of star value = old estimate + step size * (reward value - old estimate)
    @estimated_star_values[star_id] = @estimated_star_values[star_id] + (1.0/@star_eat_count[star_id]) * (reward - @estimated_star_values[star_id])
  end

  def update_target(environment_data, tick_count)
    update_explore_exploit_strategy(environment_data, tick_count)
    @id_of_selected_star_to_eat = @current_strategy == :explore ? exploration_star_id(environment_data) : exploitation_star_id(environment_data)
  end

  private

  # For now, very simply explore until we have sampled all of the stars, then start exploiting.
  def update_explore_exploit_strategy(environment_data, tick_count)
    if @do_one_time_sampling
      exploit_if_all_stars_sampled
    # TODO: change these to values created by a GA
    # only explore up to a certain point in the episode, then purely exploit
    elsif environment_data[:episode_length].to_f / tick_count < 0.3
      @current_strategy = :explore if rand < @exploration_threshold
    else
      @current_strategy = :exploit
    end
  end

  def exploit_if_all_stars_sampled
    if @current_strategy == :explore
      @current_strategy = :exploit if @estimated_star_values.size >= @max_num_stars_seen
    end
  end

  def exploitation_star_id(environment_data)
    return @incorporate_distance ? id_of_greatest_value_for_distance_star(environment_data) : id_of_highest_valued_star
  end

  # returns id of star w/ highest value, without regard to how far away that star is
  def id_of_highest_valued_star
     # assuming there will at least be a star id 0, so default to it
    highest_value_star_id = 0
    highest_value_star_id = @estimated_star_values.sort{|a,b| a[1]<=>b[1]}.last[0] if @estimated_star_values.size > 0
    return highest_value_star_id
  end

  # returns id of star that statisfies max of value/distance
  def id_of_greatest_value_for_distance_star(environment_data)
    sorted_star_values = @estimated_star_values.sort{|a,b| a[1]<=>b[1]}
    stars_by_value_distance = @estimated_star_values.map{|id_and_val| [id_and_val[0], distance_value(id_and_val, environment_data)]}
    sorted_stars_by_value_distance = stars_by_value_distance.sort{|a,b| a[1]<=>b[1]}
    return sorted_stars_by_value_distance.last[0]
  end

  def distance_value(id_and_val, environment_data)
    ship_max_speed = environment_data[:ship_max_speed]
    ship_position = environment_data[:ship_position]
    star_id_and_position = environment_data[:star_position_hash].find{ |a| a[0] == id_and_val[0] }
    star_position = star_id_and_position[1] if star_id_and_position
    if star_position
      time_step_distance = Velocity.new(Vector.new(star_position.x - ship_position.x, star_position.y - ship_position.y)).magnitude / ship_max_speed
      return id_and_val[1].to_f / time_step_distance
    else
      return -99999
    end
  end

  def exploration_star_id(environment_data)
    # ids of all stars - id of highest valued star
    non_highest_valued_star_ids = environment_data[:star_position_hash].keys - [id_of_highest_valued_star]
    # if there is a star we have not sampled yet then sample it
    unsampled_stars = non_highest_valued_star_ids - environment_data[:star_position_hash].keys
    selected_id = unsampled_stars.empty? ? non_highest_valued_star_ids.random_element : unsampled_stars.first
    return @move_towards_specified_star.calc_velocity(selected_id, environment_data)
  end

end