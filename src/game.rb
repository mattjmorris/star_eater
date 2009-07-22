require File.dirname(__FILE__) + "/physics/position"
require File.dirname(__FILE__) + "/physics/velocity"
require File.dirname(__FILE__) + "/physics/vector"
require File.dirname(__FILE__) + "/components/environment"
require File.dirname(__FILE__) + "/star_factory"
require File.dirname(__FILE__) + "/components/ship"
require File.dirname(__FILE__) + "/policy/policy"

class Game

  attr_reader :environment, :num_ticks
  
  def initialize(params = {})
    @environment = Environment.new(params)
    initialize_stars(params)
    initialize_ships()
    @environment.finalize()
    @num_ticks = 0
    $GAME_INFO = {}
  end

  def tick

    @num_ticks += 1

    $GAME_INFO[:tick_count] = @num_ticks

    @environment.ships.each do |ship|
      ship.tick(@environment.star_collection.position_hash)
      @environment.star_collection.tick(ship)
    end

    #@star_collection.tick(ship)

    star_id_to_reward = {}
    @environment.star_collection.stars.each {|star| star_id_to_reward[star.id] = star.reward_function_description}

    $GAME_INFO[:star_info_hash] = star_id_to_reward

  end

  private

  def initialize_stars(params)
    num_stars = params[:num_stars] || 1
    num_stars.times{|idx| @environment.add_star(Star.new(:max_x => @environment.width, :max_y => @environment.height))}
  end

  def initialize_ships()
    # Ship A
    policy_a = Policy.new
    mtcs = MoveTowardsClosestStar.new
    mtcs.weight = 2
    policy_a.add_action(mtcs)
    position_a = Position.new(@environment.width/2, @environment.height/2)
    ship_a = Ship.new(policy_a, position_a)
    @environment.add_ship(ship_a)
  end
end

