# Responsible for creating different types of star collections.
require File.dirname(__FILE__) + "/star_collection"

class StarFactory

  def self.get_star_collection(collection_type, num_stars, width, height)
    return self.send(collection_type, num_stars, width, height)
  end

  private

  def self.simple(num_stars, width, height)
    star_collection = StarCollection.new
    num_stars.times do
      star = Star.new(:max_x => width, :max_y => height)
      star.visible_limit = rand(100)
      star.invisible_limit = 20
      star.reward_function = lambda{10}
      star.reward_function_description = "FR1: 10"
      star_collection << star
    end
    return star_collection
  end

  def self.progressive(num_stars, width, height)
    star_collection = StarCollection.new
    num_stars.times do |idx|
      star = Star.new(:max_x => width, :max_y => height)
      star.visible_limit = 100
      star.invisible_limit = 1
      star.reward_function = lambda{idx * 5}
      star.reward_function_description = "FR1: #{idx * 5}"
      star_collection << star
    end
    return star_collection
  end

end