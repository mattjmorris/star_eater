require "spec"
require File.dirname(__FILE__) + "/../../src/components/environment"
require File.dirname(__FILE__) + "/../../src/components/star"
require File.dirname(__FILE__) + "/../../src/components/ship"

describe Environment do

  before(:all) do
    @environment = Environment.new
  end

  after(:each) do
  end

  it "should have 2D area" do
    @environment.width.should_not be_nil
    @environment.height.should_not be_nil
  end

  it "should accept the addition of star collections" do
    sc = StarCollection.new
    sc.stars << Star.new
    @environment.add_star_collection(sc)
    @environment.data[:stars].length.should > 0
  end

  it "should accept the addition of ships" do
    @environment.add_ship(mock(Ship))
    @environment.data[:ships].length.should > 0
  end
end