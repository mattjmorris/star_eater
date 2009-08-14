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

<<<<<<< HEAD:spec/brain/decision_tree_spec.rb
  it "should return a next velocity" do
    @brain.set_data(@data, 5)
    @brain.next_velocity.class.should == Velocity
  end

  it "should add a captured star to the training data set with correct attributes" do
    @brain.set_data(@data, 5)
    
  end
=======
  it "should return a next velocity" #do
  #  star = mock(Star)
  #  star.should_receive()
  #  @environment.should_receive(:data).and_return({:stars => })
  #  @brain.should_receive(:next_velocity).and_return(Velocity.new_with_xy(0,0))
  #  @brain.ship.tick(mock(Environment)).class.should be(Velocity)
  #end

  it "should add a captured star to the training data set with correct attributes"
>>>>>>> fffd8f65f94df4f3aad1ec0f694f3eb9052b13f0:spec/brain/decision_tree_spec.rb

  private

  def setup
    @brain = DecisionTreeBrain.new
<<<<<<< HEAD:spec/brain/decision_tree_spec.rb
    @data = {:star_position_hash => {1 => Position.new(25,25), 2 => Position.new(100,0)},
             :ship_position => Position.new(0,0), :reward => nil, :star_id_delivering_reward => nil}
=======
    position = Position.new(0,0)
    ship = Ship.new(@brain, position)
    @environment = mock(Environment)
>>>>>>> fffd8f65f94df4f3aad1ec0f694f3eb9052b13f0:spec/brain/decision_tree_spec.rb
  end

end
