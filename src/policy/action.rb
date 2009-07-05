require 'observer'
require File.dirname(__FILE__) + "/../physics/velocity"

module Action
  include Observable

  attr_accessor :weight
  attr_reader :name, :velocity, :info

  def initialize(name)
    @name = name
    @weight = 1
    @velocity = Velocity.new_with_xy(0,0)
    @info = ""
  end

  def notify(msg)
    changed
    notify_observers(msg)
  end
   
end