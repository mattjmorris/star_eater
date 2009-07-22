require "spec"
require File.dirname(__FILE__) + "/../src/policy/policy"
require File.dirname(__FILE__) + "/../src/policy/action"
require File.dirname(__FILE__) + "/../src/components/ship"

describe Policy do

  before(:each) do
    @policy = Policy.new
    @policy.add_action(mock_action(:action_one, 2, Velocity.new_with_xy(10,10)))
    @policy.add_action(mock_action(:action_three, 3, Velocity.new_with_xy(20,-20)))
  end

  it "should return a velocity from the top action when n_top_actions_to_select is set to 1 (default)" do
    velocity = @policy.calc_velocity(static_ship)
    velocity.x.should == 20
    velocity.y.should == -20
  end

  it "should return a normalized, summed velocity from the top 2 actions when n_top_actions_to_select is set to 2" do
    @policy.num_top_actions_to_select = 2
    velocity = @policy.calc_velocity(static_ship)
    velocity.x.should == 16
    velocity.y.should == -8
  end

  it "should return a normalized, summed velocity for all actions when n_top_actions_to_select is set to greater than the number of actions" do
    @policy.num_top_actions_to_select = 3
    velocity = @policy.calc_velocity(static_ship)
    velocity.x.should == 16
    velocity.y.should == -8
  end

  private

  def mock_action(name, weight, velocity)
    mock_action = mock(Action)
    mock_action.stub!(:name).and_return(name)
    mock_action.stub!(:weight).and_return(weight)
    mock_action.stub!(:calc_velocity)
    mock_action.stub!(:velocity).and_return(velocity)
    mock_action.stub!(:info).and_return("did stuff")
    return mock_action
  end

  def static_ship
    ship = mock(Ship)
    ship.stub!(:star_position_hash).and_return({1 => Position.new(100,100), 2 => Position.new(500,100)})
    return ship
  end

end