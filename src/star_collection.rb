require File.dirname(__FILE__) + "/star"

class StarCollection

  attr_accessor :stars
  
  def initialize
    @stars = []
  end

  def <<(star)
    @stars << star
  end

  def tick(ship)

#debug("star position is #{@stars.first.position}")
#debug("ship position is #{ship.position}")
#@stars.each { |star| debug("collision = #{star.collision?(ship.position)}") }
#@stars.each { |star| debug("star is visible = #{star.visible}") }

    @stars.each { |star| star.hyperspace if star.collision?(ship.position) }

  end

  # A hash of ids and positions of currently visible stars.  Intended to allow ships to see only 'non-sensitive'
  # information about the stars, so that they don't have access to a star's parameters.
  def position_hash
    position_hash = {}
    @stars.each { |star| position_hash[star.id] = star.position if star.visible}
    return position_hash
  end

end