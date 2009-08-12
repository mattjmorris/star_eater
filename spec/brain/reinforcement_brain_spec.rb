require "spec"
require File.dirname(__FILE__) + "/../../src/components/ship"
require File.dirname(__FILE__) + "/../../src/physics/position"
require File.dirname(__FILE__) + "/../../src/physics/velocity"
require File.dirname(__FILE__) + "/../../src/brains/policy_based/reinforcement_brain"
require File.dirname(__FILE__) + "/../../src/components/environment"


describe ReinforcementBrain do

  it "should utilize a ship's knowledge of the environment to select the next tick's velocity" do
    $GAME_INFO = {}
    brain = ReinforcementBrain.new
    position = Position.new(0,0)
    ship = Ship.new(brain, position)
    brain.should_receive(:next_velocity).and_return(Velocity.new_with_xy(0,0))
    ship.tick(mock(Environment)).class.should be(Velocity)
  end

end