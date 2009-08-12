require File.dirname(__FILE__) + "/physics/position"
require File.dirname(__FILE__) + "/physics/velocity"
require File.dirname(__FILE__) + "/physics/vector"
require File.dirname(__FILE__) + "/components/environment"
require File.dirname(__FILE__) + "/star_factory"
require File.dirname(__FILE__) + "/components/ship"
require File.dirname(__FILE__) + "/brains/policy_based/policies/policy"
require File.dirname(__FILE__) + "/brains/policy_based/reinforcement_brain"
require File.dirname(__FILE__) + "/brains/policy_based/simple_brain"

class Game

  attr_reader :environment, :num_ticks, :ship, :star_collection
  
  def initialize(params = {})
    @environment = Environment.new(params)
    @star_collection = StarFactory.get_progressive_star_collection(@environment)
    @ship = initialize_ship(params)

    @environment.add_star_collection(@star_collection)
    @environment.add_ship(@ship)

    @num_ticks = 0
    $GAME_INFO = {}
  end

  def tick

    @num_ticks += 1

    $GAME_INFO[:tick_count] = @num_ticks

    @ship.tick(@environment)
    @star_collection.tick(@ship)

    star_id_to_reward = {}
    @star_collection.stars.each {|star| star_id_to_reward[star.id] = star.reward_function_description}
    $GAME_INFO[:star_info_hash] = star_id_to_reward

  end

  private

  def get_brain(params)
    brain_name = params[:brain] || :Brain
    return Object::const_get(brain_name.to_s).new()
  end

  def initialize_ship(params)
    brain = get_brain(params)
    position = Position.new(@environment.width/2, @environment.height/2)
    Ship.new(brain, position)
  end
  
end

