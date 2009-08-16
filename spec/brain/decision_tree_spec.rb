require "spec"
require File.dirname(__FILE__) + "/../../src/components/ship"
require File.dirname(__FILE__) + "/../../src/physics/position"
require File.dirname(__FILE__) + "/../../src/physics/velocity"
require File.dirname(__FILE__) + "/../../src/components/environment"
require File.dirname(__FILE__) + "/../../src/brains/decision_tree_brain"

describe DecisionTreeBrain do

  before :each do
    setup
  end

  it "should return a next velocity" do
    @brain.training_mode=true
    data = {:star_position_hash => {1 => Position.new(25,25)}, :ship_position => Position.new(0,0)}
    @brain.set_data(data, nil)
    @brain.next_velocity.class.should == Velocity
  end

  it "in training mode should add a captured star to the training data set with correct attributes" do
    @brain.training_mode=true
    @brain.stub(:write_array_result_to_csv_file)
    @brain.should_receive(:write_array_result_to_csv_file)

    data = {:star_position_hash => {1 => Position.new(25,25)}, :ship_position => Position.new(20,20)}
    @brain.set_data(data, nil)
    data = {:star_position_hash => {2 => Position.new(50,50)}, :ship_position => Position.new(25,25), :reward => 5, :star_id_delivering_reward => 1}
    @brain.set_data(data, nil)
  end

  private

  def setup
    @brain = DecisionTreeBrain.new
  end

end
