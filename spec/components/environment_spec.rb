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

  it "should have 2D width" do
    @environment.width.should_not be_nil
    @environment.height.should_not be_nil
  end

  it "should accept the addition of new stars" do
    @environment.add_element(Star.new)
    @environment.stars.length.should > 0
  end

  it "should accept the addition of ships"
end