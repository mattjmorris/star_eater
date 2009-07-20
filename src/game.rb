require File.dirname(__FILE__) + "/physics/position"
require File.dirname(__FILE__) + "/physics/velocity"
require File.dirname(__FILE__) + "/physics/vector"
require File.dirname(__FILE__) + "/components/environment"
require File.dirname(__FILE__) + "/star_factory"
require File.dirname(__FILE__) + "/components/ship"
require File.dirname(__FILE__) + "/policy/policy"

class Game

  attr_reader :environment, :num_ticks, :star_collection
  
  def initialize(params = {})
    @environment = Environment.new(params)
    num_stars = params[:num_stars] || 1
    num_stars.times{|idx| @environment.add_star(Star.new(:max_x => @environment.width, :max_y => @environment.height))}
    @star_collection = StarFactory.get_simple_star_collection(@environment)

    @environment.add_ship(Ship.new(@environment, Velocity.new_with_xy(0,0)))
    @num_ticks = 0
  end

  def tick

    @num_ticks += 1

    $LOGGER.info("Tick Count: #{@num_ticks}") if $D    

    @environment.ships.each do |ship|
      ship.tick(@star_collection.position_hash)
      @star_collection.tick(ship)
    end

  end

end

