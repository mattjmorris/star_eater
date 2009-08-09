class Environment

  attr_accessor :width, :height, :ship_position, :star_collection


  def tick(ship_velocity, tick_count)
    # update ship's position
    @ship_position = @ship_position.move(ship_velocity)
puts
puts "the ship position is #{@ship_position}"
puts  
    $GAME_INFO[:ship_position] = @position
    # see if ship connected with any stars, and if so, record any rewards


  end

  # Can obfuscate as much as we like
  def data
    {:star_position_hash => position_hash(@star_collection.stars), :ship_position => @ship_position}
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
