require "spec"
require File.dirname(__FILE__) + "/../../src/brains/policy_based/actions/move_towards_closest_star"
require File.dirname(__FILE__) + "/../../src/components/ship"
require File.dirname(__FILE__) + "/../../src/physics/position"
require File.dirname(__FILE__) + "/../../src/physics/velocity"

describe MoveTowardsClosestStar do

  before(:each) do
    @environment_data = {:star_position_hash => {1 => Position.new(100,100), 2 => Position.new(500,100)}, :ship_position => Position.new(50,50)}
    @mtcs = MoveTowardsClosestStar.new
    $GAME_INFO = {}
  end

  it "should produce a velocity that points from the ship's position to the closest star" do

    velocity = @mtcs.calc_velocity(@environment_data)

    # velocity should point at the first star, not the second, since the first is closer
    velocity.x.should == 50
    velocity.y.should == 50

    $GAME_INFO[:action_info].should == "MoveTowardsClosestStar has found closest star to be id 1 and has set velocity to moves towards it"

  end

end