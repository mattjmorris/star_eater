require "spec"
require File.dirname(__FILE__) + "/../../src/components/star"

describe Star do

  # Called before each example.
  before(:each) do
    @max_x = 100
    @max_y = 100
    @visible_limit = 10
    @invisible_limit = 5
    @star = Star.new(:max_x => @max_x, :max_y => @max_y)
    @star.visible_limit = @visible_limit
    @star.invisible_limit = @invisible_limit
  end

  it "should be assigned a unique id when it is created" do
    @ids = []
    10.times{@ids << Star.new.id}
    @ids.uniq.size.should be(10)
  end

  it "should have a position that is between the origin and max_x,max_y" do
    @star.position.x.should be > 0
    @star.position.x.should be < @max_x
    @star.position.y.should be > 0
    @star.position.y.should be < @max_y    
  end

  it "should be visible for a set period of time" do

    @star.visible.should be(true)

    @visible_limit.times do
      @star.tick
      @star.visible.should be(true)
    end

    @star.tick
    @star.visible.should be(false)

  end

  it "should be invisible for a set period of time" do

    (@visible_limit + 1).times {@star.tick}
    @star.visible.should be(false)

    @invisible_limit.times do
      @star.tick
      @star.visible.should be(false)
    end

    @star.tick
    @star.visible.should be(true)

  end

  it "should detect contact when another object's position is within the star's diameter" do

    other_position = @star.position.clone

    # put the position just within the diameter    
    other_position.x += @star.diameter - 1
    @star.collision?(other_position).should be(true)

    # put the position at the diameter - should not be detected as a colision
    other_position.x += @star.diameter
    @star.collision?(other_position).should be(false)

  end

  it "should only detect contact if it is visible" do

    @star.visible = false
    other_position = @star.position.clone
    @star.collision?(other_position).should be(false)

  end

  it "hyperspace should cause it to change position and become invisible" do

    current_position = @star.position.clone
    @star.visible.should be(true)
    @star.position.x.should == current_position.x
    @star.position.y.should == current_position.y

    @star.hyperspace
    @star.visible.should be(false)
    @star.position.x.should_not == current_position.x
    @star.position.y.should_not == current_position.y    

  end

  it "should have a reward that is delivered based on collisions and reward function" do

    @star.reward_function = lambda{5}
    @star.get_reward.should be(0) # no reward set up before collision
    @star.collision?(@star.position)
    @star.get_reward.should be(5)
    @star.get_reward.should be(0) # reward disappears after it is taken

  end


end