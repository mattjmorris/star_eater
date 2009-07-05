require "spec"
require File.dirname(__FILE__) + "/../../src/physics/position"
require File.dirname(__FILE__) + "/../../src/physics/vector"
require File.dirname(__FILE__) + "/../../src/physics/velocity"

describe Position do

  it "should be initialized with an x and y coordinate" do

    pos = Position.new(10,20)
    pos.x.should == 10
    pos.y.should == 20

  end

  it "should tell if another Position object is less than some distance from itself" do

    pos1 = Position.new(10, 10)
    pos2 = Position.new(10, 20)
    pos1.within_diameter?(11, pos2).should == true
    pos1.within_diameter?(10, pos2).should == false

    pos1 = Position.new(10, 10)
    pos2 = Position.new(10, 10)
    pos1.within_diameter?(1, pos2).should == true
    pos1.within_diameter?(0, pos2).should == false    

  end

  it "should give the distance between itself and another Postion object" do

    pos1 = Position.new(10, 10)
    pos2 = Position.new(10, 20)
    pos1.distance(pos2).should == 10

    pos1 = Position.new(10, 10)
    pos2 = Position.new(20, 20)
    pos1.distance(pos2).should be_close(14.14, 0.009)

  end

  it "should give a new position when told to move with a velocity" do

    pos1 = Position.new(10,10)
    vel = Velocity.new(Vector.new(5,-5))
    pos2 = pos1.move(vel)
    pos2.x.should == 15
    pos2.y.should == 5
    
  end

  it "should return a vector to a second point" do

    pos1 = Position.new(5,10)
    pos2 = Position.new(10,5)
    vector = pos1.get_vector_to(pos2)
    vector.x.should == 5
    vector.y.should == -5
    
  end

  it "should pretty-print itself" do

    Position.new(10,20).to_s.should == "x => 10, y => 20"
    
  end

end