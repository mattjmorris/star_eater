require File.dirname(__FILE__) + "/physics/position"
require File.dirname(__FILE__) + "/util/auto_id"

class Star
  include AutoId

  attr_accessor :diameter, :visible
  attr_reader :position, :id

  def initialize (params = {:max_x => 600, :max_y => 800, :visible_limit => 10, :invisible_limit => 10})

    assign_id(id)
    
    @diameter = 15
    set_min_and_max_x_and_y(params[:max_x], params[:max_y])
    set_new_random_position

    @visible_limit = params[:visible_limit]
    @invisible_limit = params[:invisible_limit]

    @visible = true
    reset_visiblility_counters

    @tick_count = 0
    
  end

  # Did contact occur?  Note that right now intersection is only possible if self is visible
  def collision?(other_position)
    @visible && @position.within_diameter?(@diameter, other_position)
  end

  def tick
    @tick_count += 1
    @visible ? @visible_time_count += 1 : @invisible_time_count += 1
    switch_visibility if (@invisible_time_count > @invisible_limit || @visible_time_count > @visible_limit)
  end

  def hyperspace
    set_new_random_position
    switch_visibility(:visible => false)
  end

  private

  # Either sets visibility to opposite or current, or the 'force' parameter may be used to force visible or invisible.
  def switch_visibility(params = {})
    @visible = params[:visible] || !@visible
    reset_visiblility_counters
  end

  def reset_visiblility_counters
    @visible_time_count = 0
    @invisible_time_count = 0
  end

  def set_min_and_max_x_and_y(max_x, max_y)
    @max_x = max_x - @diameter / 2.to_f
    @max_y = max_y - @diameter / 2.to_f
    @min_x = @diameter / 2.to_f
    @min_y = @diameter / 2.to_f      
  end

  def set_new_random_position
    random_x = @min_x + rand(@max_x - @min_x + 1)
    random_y = @min_y + rand(@min_y = @min_y + 1)
    @position = Position.new(random_x, random_y)    
  end

end