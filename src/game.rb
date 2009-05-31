require File.dirname(__FILE__) + "/physics/position"
require File.dirname(__FILE__) + "/physics/velocity"
require File.dirname(__FILE__) + "/physics/vector"
require File.dirname(__FILE__) + "/star_factory"
require File.dirname(__FILE__) + "/ship"

class Game

  attr_reader :star_collection, :ship
  
  def initialize(size_x = 600, size_y = 800, num_stars = 1)
    @star_collection = StarFactory.get_simple_star_collection(size_x, size_y, num_stars)
    @ship = Ship.new(Position.new(size_x/2.to_f, size_y/2.to_f), Velocity.new_with_xy(0, 0))
  end

  def tick

    ship.tick(star_collection.position_hash)

    star_collection.tick(ship)

  end

end

