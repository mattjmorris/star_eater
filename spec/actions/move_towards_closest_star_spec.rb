require "spec"
require File.dirname(__FILE__) + "/../../src/policy/move_towards_closest_star"
require File.dirname(__FILE__) + "/../../src/ship"
require File.dirname(__FILE__) + "/../../src/physics/position"
require File.dirname(__FILE__) + "/../../src/physics/velocity"

describe MoveTowardsClosestStar do

  # Called before each example.
  before(:each) do
    @ship = Ship.new(Position.new(50,50), Velocity.new_with_xy(0, 0))
    @ship.star_position_hash = {1 => Position.new(100,100), 2 => Position.new(500,100)}
    @mtcs = MoveTowardsClosestStar.new
  end

  it "should produce a velocity that points from the ship's position to the closest star" do

    velocity = @mtcs.calc_velocity(@ship)

    # velocity should point at the first star, not the second, since the first is closer
    velocity.x.should == 50
    velocity.y.should == 50

    @mtcs.info.should == "Action MoveTowardsClosestStar has found closest star to be star id 1 and has set velocity to move towards it, with a weight of 1"

  end

end