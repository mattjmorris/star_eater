require "spec"
require File.dirname(__FILE__) + "/../src/velocity"
require File.dirname(__FILE__) + "/../src/vector"

describe Velocity do

  # Called before each example.
  before(:each) do
    @vel1 = Velocity.new(Vector.new(5, 10))
    @vel2 = Velocity.new(Vector.new(5, -5))
  end

  it "can be initialized with a vector" do
    vel = Velocity.new(Vector.new(5, 10))
    vel.x.should == 5
    vel.y.should == 10
  end

  it "can be initialized with an x and a y" do
    vel = Velocity.new_with_xy(5,10)
    vel.x.should == 5
    vel.y.should == 10    
  end

  it "has a magnitude" do
    @vel1.magnitude.should be_close(0.009, 11.18)
    @vel2.magnitude.should be_close(0.009, 7.07)
  end

  it "can do addition with another velocity object" do
    new_vel = @vel1 + @vel2
    new_vel.x.should == 10
    new_vel.y.should == 5
  end

  it "can do subtraction with another velocity object" do
    new_vel = @vel1 - @vel2
    new_vel.x.should == 0
    new_vel.y.should == 15
  end

  it "can do multiplication with a scalar" do
    new_vel = @vel1 * 2
    new_vel.x.should == 10
    new_vel.y.should == 20
  end

  it "can do division with a scalar" do
    new_vel = @vel1 / 2
    new_vel.x.should == 2.5
    new_vel.y.should == 5
  end

end