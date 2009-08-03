require File.dirname(__FILE__) + "/brain"

class SimpleBrain < Brain
  def initialize
    super
    @target = nil
  end

  def next_velocity(ship)
    @ship = ship
    verify_target 
    velocity = Velocity.new(ship.position.get_vector_to(@target))
    velocity
  end

  private

  def verify_target
    if @target.nil? || !star_at_position(@target)
      @target = @ship.star_position_hash[rand(@ship.star_position_hash.length)]
    end
  end

  def star_at_position(position)
    @ship.star_position_hash.detect{|key,value| value == position }
  end

end