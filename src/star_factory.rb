# Responsible for creating different types of star collections.
require File.dirname(__FILE__) + "/star_collection"

class StarFactory

  def self.get_simple_star_collection(max_x, max_y, num_stars)
    star_collection = StarCollection.new
    num_stars.times do
      star_collection << Star.new(:max_x => max_x, :max_y => max_y, :visible_limit => rand(30), :invisible_limit => 5)
    end
    return star_collection
  end
  
end
