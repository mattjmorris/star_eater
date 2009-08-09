require File.dirname(__FILE__) + "/star"

class StarCollection

  attr_accessor :stars
  
  def initialize
    @stars = []
  end

  def <<(star)
    @stars << star
  end

  def tick(ship_position)

    current_reward = 0
    star_id_delivering_reward = nil

    @stars.each do |star|
      star.tick
      if star.collision?(ship_position)
        star.hyperspace
        current_reward = star.get_reward
        star_id_delivering_reward = star.id
        #ship.deliver_reward(current_reward, star.id)
        $GAME_INFO[:star_eaten] = star.id
        $GAME_INFO[:star_reward] = current_reward
        break #note that we break after the first collision, so only one star may be eaten at a time, even if > 1 were collided with.
      end
    end

    return current_reward, star_id_delivering_reward

  end

end