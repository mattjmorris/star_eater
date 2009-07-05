require 'observer'
require File.dirname(__FILE__) + "/move_towards_closest_star"
require File.dirname(__FILE__) + "/move_away_closest_star"
require File.dirname(__FILE__) + "/do_nothing"

class Policy
  include Observable

  attr_accessor :num_top_actions_to_select
  attr_reader :actions, :velocity
  
  def initialize
    # A set of actions should be set via actions accessor or else the ship will just sit in place (do nothing) 
    @actions = [DoNothing.new]
    @actions[0].add_observer(self)
    @last_action_info = ""
    @num_top_actions_to_select = 1
  end

  def add_action(action)
    action.add_observer(self)
    @actions << action
  end

  def calc_velocity(ship)
    velocity = get_velocity_from_top_actions(ship)
    #update_observer_info
    return velocity
  end

  # pass on notifications from sub-elements to observers
  def update(msg)
    notify(msg)
  end
  
  private

  # Returns a velocity that is the normalized, weighted sum of each top action's velocity 
  def get_velocity_from_top_actions(ship)
    top_actions = get_top_n_actions
    top_actions.each { |a| a.calc_velocity(ship) }
    get_weighted_summed_velocity(top_actions)
  end

  # Returns an array of the top n actions by weight
  def get_top_n_actions
    @actions.sort!{|a,b| b.weight<=>a.weight}
    @actions[0, @num_top_actions_to_select]
  end

  def get_weighted_summed_velocity(top_actions)
    summed_velocity = Velocity.new_with_xy(0, 0)
    top_actions.each { |a| summed_velocity += (a.velocity * a.weight)}
    # now normalize the velocity
    summed_weights = top_actions.inject(0) { |sum, action| sum + action.weight }
    return summed_velocity / summed_weights
  end

  def notify(msg)
    changed
    notify_observers(msg)
  end

end