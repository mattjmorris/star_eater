require File.dirname(__FILE__) + "/environment"
require File.dirname(__FILE__) + "/star_factory"
require File.dirname(__FILE__) + "/star_collection"
require File.dirname(__FILE__) + "/../physics/position"

# MJM: motivation behind creating this class is that it makes our code more easily extensible.  Some things that may
# be added in the future include environment info fuzz factor, ship navigation fuzz factor, and multiple ships.
class EnvironmentFactory

  def self.create_environment(params = {})

    environment = Environment.new(params[:recorder])

    width = params[:width] || 800
    height = params[:height] || 600
    environment.width = width
    environment.height = height
    environment.episode_length = params[:episode_length]
    environment.ship_position = Position.new(width/2, height/2)

    num_stars = params[:num_stars] || 1
    star_collection_type = params[:star_collection_type] || :simple
    environment.star_collection = StarFactory.create_star_collection(star_collection_type, num_stars, width, height)

    return environment

  end

end