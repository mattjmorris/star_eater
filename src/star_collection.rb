require File.dirname(__FILE__) + "/star"
#require 'observer'

class StarCollection
  #include Observable

  attr_accessor :stars
  
  def initialize
    @stars = []
  end

  def <<(star)
    @stars << star
  end

  def tick(ship)

    current_reward = nil

    @stars.each do |star|
      star.tick
      if star.collision?(ship.position)
        #notify("star #{star.id} was just eaten", :info)
        star.hyperspace
        current_reward = star.get_reward
        ship.deliver_reward(current_reward, star.id)
        $LOGGER.info("star #{star.id} was just eaten for a reward of #{current_reward}") if $D
        break #note that we break after the first collision, so only one star may be eaten at a time, even if > 1 were collided with.
      end
    end

  end

  # A hash of ids and positions of currently visible stars.  Intended to allow ships to see only 'non-sensitive'
  # information about the stars, so that they don't have access to a star's parameters.
  def position_hash
    position_hash = {}
    @stars.each { |star| position_hash[star.id] = star.position if star.visible}
    return position_hash
  end

  #private
  #
  #def notify(msg, level)
  #  changed
  #  notify_observers(msg, level)
  #end

end