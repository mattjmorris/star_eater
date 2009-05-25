require "spec"
require File.dirname(__FILE__) + "/../src/vector"

describe Vector do

  # Called before each example.
  before(:each) do
    @vector1 = Vector.new(5, 10)
    @vector2 = Vector.new(10, -5)
  end

  it "should have an x and a y" do
    @vector1.x.should == 5
    @vector1.y.should == 10
  end
  
  it "can do addition with another vector object" do
    new_vector = @vector1 + @vector2
    new_vector.x.should == 15
    new_vector.y.should == 5
  end

  it "can do subtraction with another vector object" do
    new_vector = @vector1 - @vector2
    new_vector.x.should == -5
    new_vector.y.should == 15
  end

  it "can do multiplication with a scalar" do
    new_vector = @vector1 * 2
    new_vector.x.should == 10
    new_vector.y.should == 20
  end

  it "can do division with a scalar" do
    new_vector = @vector1 / 2
    new_vector.x.should == 2.5
    new_vector.y.should == 5
  end

end