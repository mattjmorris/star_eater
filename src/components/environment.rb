class Environment

  attr_accessor :width, :height, :ship_position, :star_collection, :reward, :star_id_delivering_reward, :bank

  def initialize
    @reward = 0
    @bank = 0
  end

  def tick(ship_velocity, tick_count)
    # update ship's position
    @ship_position = @ship_position.move(ship_velocity) 
    $GAME_INFO[:ship_position] = @position

    # tick the star collection and record any rewards
    @reward = 0
    @star_id_delivering_reward = nil
    @reward, @star_id_delivering_reward = @star_collection.tick(ship_position)
    @bank += reward

  end

  # Can obfuscate as much as we like
  def data
    {:star_position_hash => position_hash(@star_collection.stars),
     :ship_position => @ship_position,
     :reward => @reward,
     :star_id_delivering_reward => @star_id_delivering_reward
    }
  end

  private

  # A hash of ids and positions of currently visible stars.  Intended to allow ships to see only 'non-sensitive'
  # information about the stars, so that they don't have access to a star's parameters.
  def position_hash(stars)
    position_hash = {}
    stars.each { |star| position_hash[star.id] = star.position if star.visible}
    return position_hash
  end

end
