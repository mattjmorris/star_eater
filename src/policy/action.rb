require File.dirname(__FILE__) + "/../physics/velocity"

module Action

  attr_accessor :weight
  attr_reader :name, :velocity, :info

  def initialize(name)
    @name = name
    @weight = 1
    @velocity = Velocity.new_with_xy(0,0)
    @info = ""
  end

  private

  def announce_info
    $LOGGER.info(@info)
  end
   
end