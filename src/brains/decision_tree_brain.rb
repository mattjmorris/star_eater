#require "ai4r"
require File.dirname(__FILE__) + "/brain_utility_methods"

#
# DecisionTreeBrain needs a training file in order to craft id3 rules
# Please run the program once with training mode on before using it for analysis
#
class DecisionTreeBrain
  include BrainUtilityMethods
  attr_writer :training_mode

  DATA_FILE = "decision_tree_training_data.csv"

  def initialize
    @data_labels = ["ID", "Grouping", "Worthwhile?"]
    @training_mode = false
    @target = {}
    write_labels_to_csv_file(DATA_FILE, @data_labels) if @training_mode
  end

  def set_data(data, count)
    @data = data
    analyze_new_environment_data  
  end

  def next_velocity
    velocity_to(@target[:position])
  end

  private

  def distance_grouping(distance)
    (distance > 400 ? "> 400" : (distance >= 200) ? "200-400" : "< 200")
  end  
  
  def analyze_new_environment_data
    @ship_position = @data[:ship_position]
    process_and_clear_target if reward_given?
    determine_next_target unless @target[:id]
  end

  def determine_next_target
    if (@training_mode)
      star = nearest_star(@data[:star_position_hash])
    else
      star = get_decision_tree_next_star
    end
    @target = {:id => star[:id], :position => star[:position], :initial_distance => star_dist(star[:position])}
  end

  def get_decision_tree_next_star
    @id3 ||= build_id3
    id3_worthy_targets = @data[:star_position_hash].select{|id,position| @id3.eval([id.to_s, distance_grouping(star_dist(position))]) }
    id3_worthy_targets.empty? ? nearest_star(@data[:star_position_hash]) : nearest_star(id3_worthy_targets)
  end

  def process_and_clear_target
    write_array_result_to_csv_file(DATA_FILE,get_training_data_result) if @training_mode
    @target = {:id => nil, :position => nil, :initial_distance => nil}
  end  

  def get_training_data_result
    group = distance_grouping(@target[:initial_distance])
    training_worth_estimate = (@data[:reward]/@target[:initial_distance] > 0.016) ? "Yes" : "No"
    result = [@target[:id], group, training_worth_estimate]
  end

  def build_id3
    data_items = load_csv_array_with_labels(DATA_FILE)
    data_set = Ai4r::Data::DataSet.new(:data_items=>data_items, :data_labels=>@data_labels)
    id3 = Ai4r::Classifiers::ID3.new.build(data_set)
    #puts id3.get_rules
    id3
  end

end