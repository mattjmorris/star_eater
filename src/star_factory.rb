# Responsible for creating different types of star collections.
require File.dirname(__FILE__) + "/star_collection"

class StarFactory

  def self.get_simple_star_collection(max_x, max_y, num_stars)
    star_collection = StarCollection.new
    num_stars.times do
      star = Star.new(:max_x => max_x, :max_y => max_y)
      star.visible_limit = rand(100)
      star.invisible_limit = 20
      star.reward_function = lambda{10}
      star_collection << star
    end
    return star_collection
  end

  def self.get_progressive_star_collection(max_x, max_y, num_stars)
    star_collection = StarCollection.new
    num_stars.times do |count|
      star = Star.new(:max_x => max_x, :max_y => max_y)
      star.visible_limit = 100
      star.invisible_limit = 1
      star.reward_function = lambda{count * 5}
      star.reward_function_description = "FR1: #{count * 5}"
      star_collection << star
    end
    return star_collection
  end
  
end
