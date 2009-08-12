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

  it "should return a next velocity" #do
  #  star = mock(Star)
  #  star.should_receive()
  #  @environment.should_receive(:data).and_return({:stars => })
  #  @brain.should_receive(:next_velocity).and_return(Velocity.new_with_xy(0,0))
  #  @brain.ship.tick(mock(Environment)).class.should be(Velocity)
  #end

  it "should add a captured star to the training data set with correct attributes"

  private

  def setup
    @brain = DecisionTreeBrain.new
    position = Position.new(0,0)
    ship = Ship.new(@brain, position)
    @environment = mock(Environment)
  end

end