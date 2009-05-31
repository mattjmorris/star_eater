class Ship
  MAX_SPEED = 20

  attr_reader :velocity, :position, :diameter
  attr_writer :star_position_hash

  def initialize(position, velocity)
    @position = position
    @velocity = velocity
    @diameter = 20
  end

  def tick(position_hash)
    @star_position_hash = position_hash
    closest_star_position = (@star_position_hash.values.sort{|a, b| @position.distance(a) <=> @position.distance(b)}).first
    @velocity = Velocity.new(@position.get_vector_to(closest_star_position), MAX_SPEED)
    @position = @position.move(@velocity)
  end

end