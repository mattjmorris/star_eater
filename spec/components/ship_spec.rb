require "spec"
require File.dirname(__FILE__) + "/../../src/components/ship"
require File.dirname(__FILE__) + "/../../src/components/environment"
require File.dirname(__FILE__) + "/../../src/physics/position"
require File.dirname(__FILE__) + "/../../src/star_collection"
require File.dirname(__FILE__) + "/../../src/physics/velocity"


describe Ship do

  # Called before each example.
  before(:each) do
    brain = mock(Brain)
    brain.stub!(:next_velocity).and_return(Velocity.new_with_xy(0,0))
    @ship = Ship.new(brain, Position.new(0,0))
  end

  it "should have a position and a velocity" do
    @ship.position.x.should be(0)
    @ship.position.y.should be(0)
    @ship.velocity.x.should be(0)
    @ship.velocity.x.should be(0)
  end

  it "should accept rewards delivered from stars, and then update its 'bank'" do
    $GAME_INFO = {}
    @ship.bank.should be(0)
    reward_amount = 10
    star_id = 2
    @ship.deliver_reward(reward_amount, star_id)
    @ship.bank.should be(reward_amount)
  end

  it "should receive an environment when tick is called and return a velocity" do
    env = mock(Environment)
    star_c = mock(StarCollection)
    star_c.stub!(:position_hash).and_return({})
    env.stub!(:star_collection).and_return(star_c)
    @ship.tick(env).class.should be(Velocity)
  end

end