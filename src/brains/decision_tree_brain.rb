#
# Instructions for using decision tree brain
#
# Set your data groupings  (group method)
# Set your worthwhile boolean
# Train up a set of data by turning on @training_mode
# Turn off training mode and run simulation

require "ai4r"
require File.dirname(__FILE__) + "/brain_utility_methods"

# mean = 0.0246; median = 0.0163 - reward/distance
class DecisionTreeBrain
  include BrainUtilityMethods

  def initialize
    @training_file = "decision_tree_training_data.csv"
    @data_labels = ["ID", "Grouping", "Winner"]
    @target = {:id => nil, :position => nil, :initial_distance => nil}
    @training_mode = false
    @training_result = []
    write_labels_to_file(@data_labels) if @training_mode
  end

  def set_data(data, count)
    @data = data
    @ship_position = @data[:ship_position]
    analyze_target_situation
  end

  def next_velocity
    velocity = Velocity.new(Vector.new((@target[:position].x - @ship_position.x), (@target[:position].y - @ship_position.y)))
    velocity
  end

  private

  def get_next_target  
    if (@training_mode)
      star = nearest_star(@data[:star_position_hash])
    else
      star = get_decision_tree_next_star
    end
    @target = {:id => star[:id], :position => star[:position], :initial_distance => star_dist(star[:position])}
  end

  def get_decision_tree_next_star
    @id3 ||= build_id3
    # limit stars to worthwhile ones
    useful_targets = @data[:star_position_hash].select do |id,position|
      group = group(star_dist(position))
      @id3.eval([id.to_s, group])
    end
    nearest_star(useful_targets)
  end

  def analyze_target_situation
    if @data[:star_id_delivering_reward] && @data[:star_id_delivering_reward] == @target[:id]
      write_result_to_file(get_training_data_result) if @training_mode
      @target = {:id => nil, :position => nil, :initial_distance => nil}
    end
    get_next_target unless @target[:position] && @target[:id]
  end

  def build_id3
    data_items = load_csv_with_labels
    data_set = Ai4r::Data::DataSet.new(:data_items=>data_items, :data_labels=>@data_labels)
    id3 = Ai4r::Classifiers::ID3.new.build(data_set)
    #p id3.get_rules
    id3
  end

  def get_training_data_result
    group = group(@target[:initial_distance])
    reward = @data[:reward]
    worthwhile = (reward/@target[:initial_distance] > 0.016) ? 1 : 0
    result = [@target[:id], group, worthwhile]
    result
  end

  # Use this to define groups delineating the cost to get to the star
  def group(distance)
    if (distance > 400)
      "far"
    elsif (distance < 400 && distance > 200)
      "medium"
    else
      "near"
    end
  end

  def write_labels_to_file(labels)
    File.open(@training_file, "w"){|f| f.puts labels.join(",")}
  end

  def write_result_to_file(result)
    File.open(@training_file, "a"){|f| f.puts result.join(",") }
  end

  def load_csv_with_labels
    items = []; open_csv_file(@training_file){|entry| items << entry}
    @data_labels = items.shift
    items
  end
end