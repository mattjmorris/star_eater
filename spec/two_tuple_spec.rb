require "spec"
require File.dirname(__FILE__) + "/../src/two_tuple"

describe TwoTuple do

  # Called before each example.
  before(:each) do
    @two_tuple = TwoTuple.new(5,10)
  end

  it "should contain an x and a y" do

    @two_tuple.x.should == 5
    @two_tuple.y.should == 10

  end
  
end