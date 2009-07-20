require "spec"
require File.dirname(__FILE__) + "/../../src/components/ship"
require File.dirname(__FILE__) + "/../../src/physics/position"
require File.dirname(__FILE__) + "/../../src/physics/velocity"


describe Ship do

  # Called before each example.
  before(:each) do
    @ship = Ship.new(Position.new(0,0), Velocity.new_with_xy(0, 0))
  end

  it "should have a position and a velocity" do
    @ship.position.x.should be(0)
    @ship.position.y.should be(0)
    @ship.velocity.x.should be(0)
    @ship.velocity.x.should be(0)
  end

  it "should accept rewards delivered from stars, and then update its 'bank'" do
    @ship.bank.should be(0)
    reward_amount = 10
    star_id = 2
    @ship.deliver_reward(reward_amount, star_id)
    @ship.bank.should be(reward_amount)
  end

  it "should receive a hash of star positions when tick is called" do
    position_hash = {1 => Position.new(10,10)}
    @ship.tick({})
    @ship.tick(position_hash)
  end

end