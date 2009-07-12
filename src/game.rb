require File.dirname(__FILE__) + "/physics/position"
require File.dirname(__FILE__) + "/physics/velocity"
require File.dirname(__FILE__) + "/physics/vector"
require File.dirname(__FILE__) + "/star_factory"
require File.dirname(__FILE__) + "/ship"
require File.dirname(__FILE__) + "/policy/policy"
require 'observer'

class Game
  include Observable

  attr_reader :star_collection, :ship, :num_ticks
  
  def initialize(params = {})
    size_x = params[:size_x] || 600
    size_y = params[:size_y] || 800
    num_stars = params[:num_stars] || 1
    @star_collection = StarFactory.get_simple_star_collection(size_x, size_y, num_stars)
    #@star_collection.add_observer(self)
    @ship = Ship.new(Position.new(size_x/2.to_f, size_y/2.to_f), Velocity.new_with_xy(0, 0))
    #@ship.add_observer(self)
    @num_ticks = 0
  end

  def tick

    @num_ticks += 1

    $LOGGER.info("Tick Count: #{@num_ticks}") if $D    

    ship.tick(star_collection.position_hash)

    star_collection.tick(ship)

  end

  # Updates from the game elements - pass on to Game object's observers
  #def update(msg, level)
  #  changed
  #  notify_observers(msg, level)
  #end

end

