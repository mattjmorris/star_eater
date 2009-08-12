require File.dirname(__FILE__) + "/../actions/move_towards_closest_star"
require File.dirname(__FILE__) + "/../actions/move_away_closest_star"
require File.dirname(__FILE__) + "/../actions/do_nothing"

class Policy

  attr_accessor :num_top_actions_to_select
  attr_reader :actions, :velocity
  
  def initialize
    # A set of actions should be set via actions accessor 
    @weighted_actions = {}
    @last_action_info = ""
    @last_action = nil
  end

  def add_action(action)
    @weighted_actions[action] = 1
  end

  # TODO: set up roulette selection.  Grab top weighted action (exploitation) or else do exploration
  def calc_velocity(ship)
    coin = get_coin_flip
    velocity = coin <= exploration_threshold ? exploration_action(ship) : exploitation_action(ship)
    return velocity
  end

  #TODO - right now not taking into account amount of reward (or even if it is negative)
  def deliver_reward(reward)
    @weighted_actions[@last_action] += 0.1
    p @weighted_actions
  end
  
  private

  def get_coin_flip
    return 1  # for now just pretend rand returned a 1
  end

  def exploration_threshold
    return 0 # in the future, set higher and then reduce with time or confidence
  end

  # chose the currently top weighted action
  def exploitation_action(ship)
    top_weight = @weighted_actions.sort{|x,y| y[1] <=> x[1]}.first[1]
    # there may be more than one action with top weight, so find all with that weight
    top_actions = @weighted_actions.find_all{|x| x[1] == top_weight}.map{|x| x[0]}
    # now grab one of the top actions at random
    selected_action = top_actions[rand(top_actions.size)]
    @last_action = selected_action
    selected_action.calc_velocity(ship)
  end

  # TODO: right now randomly selecting an action.  Better strategy is to do selection based on weights but don't select
  # top weighted action.
  def exploration_action(ship)
    random_action = @weighted_actions.to_a[rand(@weighted_actions.size)].first
    @last_action = random_action
    random_action.calc_velocity(ship)
  end


end