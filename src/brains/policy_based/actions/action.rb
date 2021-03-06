require File.dirname(__FILE__) + "/../../../../src/physics/velocity"

module Action

  attr_reader :name, :velocity, :info

  def initialize(name)
    @name = name
    @velocity = Velocity.new_with_xy(0,0)
    @info = ""
  end

  private

  def announce_info
    $GAME_INFO[:action_info] += @info
  end
   
end