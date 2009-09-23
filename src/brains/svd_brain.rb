require File.dirname(__FILE__) + "/brain_utility_methods"
require "linalg"

class SvdBrain
  include BrainUtilityMethods

  def initialize
    @target = {}
    generate_matrices
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
    @target = {:id => nil, :position => nil, :initial_distance => nil} if reward_given?
    determine_next_target unless @target[:id]
  end

  def determine_next_target
    star = best_star_choice_by_cosine
    @target = {:id => star[:id], :position => star[:position], :initial_distance => star_dist(star[:position])}
  end

  # compare existing stars to our data
  def best_star_choice_by_cosine
    star_array = @data[:star_position_hash].sort{|x,y| angle(y[0], y[1]) <=> angle(x[0],x[1])}.first
    {:id => star_array[0], :position => star_array[1]}
  end

  def angle(id, position)
    star_val = star_value(id, star_dist(position))
    neighbor_val = nearest_neighbor_value(position)
    comparison = Linalg::DMatrix[[star_val,neighbor_val]]
    data_point = comparison * @u2 * @eig.inverse
    (data_point.transpose.dot(@good_point.transpose)) / (@good_point.norm * data_point.norm)
  end

  def generate_matrices
    m = Linalg::DMatrix.rows(data).transpose
    u, s, v = m.singular_value_decomposition
    vt = v.transpose
    @u2 = Linalg::DMatrix.join_columns [u.column(0), u.column(1)]
    v2 = Linalg::DMatrix.join_columns [vt.column(0), vt.column(1)]
    @eig = Linalg::DMatrix.columns [s.column(0).to_a.flatten[0,2], s.column(1).to_a.flatten[0,2]]
    @good_point = v2.row(0)
    @bad_point   = v2.row(1)
  end

  def data
    # star value, neighbor value
    [
      [0.1, 0.1],  # good
      [0.001, 0.001] # bad
    ]
  end

  def star_value(id, distance)
    return 0.0001 unless id > 0 && distance > 0
    (id/distance)
  end

  def nearest_neighbor_value(position)
    neighbor = @data[:star_position_hash].reject{|id,pos| pos == position}.sort{|x,y| position.distance(x[1]) <=> position.distance(y[1])}.first
    star_value(neighbor[0], position.distance(neighbor[1]))
  end

end