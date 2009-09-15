require File.dirname(__FILE__) + "/components/ship"
require File.dirname(__FILE__) + "/components/environment_factory"
require File.dirname(__FILE__) + "/brains/brain_factory"
require File.dirname(__FILE__) + "/components/recorder"

class Game

  attr_reader :environment, :tick_count, :ship, :star_collection
  
  def initialize(params = {})

    @environment = EnvironmentFactory.create_environment(params)
    brain = BrainFactory.create_brain(params[:brain_type])
    @ship = Ship.new(brain)

    @tick_count = 0
    $GAME_INFO = {}

    star_id_to_reward = {}
    @environment.star_collection.stars.each {|star| star_id_to_reward[star.id] = star.reward_function_description}
    $GAME_INFO[:star_info_hash] = star_id_to_reward
    
  end

  def tick

    @tick_count += 1
    $GAME_INFO[:tick_count] = @tick_count

    ship_velocity = @ship.tick(@environment.data, @tick_count)

    @environment.tick(ship_velocity, @tick_count)

  end 
  
end

