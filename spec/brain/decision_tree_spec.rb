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
    @brain.set_data(@data, 5)
    @brain.next_velocity.class.should == Velocity
  end

  it "should add a captured star to the training data set with correct attributes" do
    @brain.set_data(@data, 5)
    
  end

  private

  def setup
    @brain = DecisionTreeBrain.new
    @data = {:star_position_hash => {1 => Position.new(25,25), 2 => Position.new(100,0)},
             :ship_position => Position.new(0,0), :reward => nil, :star_id_delivering_reward => nil}
  end

end
