class Environment
  attr_accessor :width, :height, :num_stars

  def initialize(params = {})
    @width = params[:size_x] || 600
    @height = params[:size_y] || 800
    @num_stars = params[:num_stars] || 1
    @ships = []
  end

  def add_star_collection(star_collection); @star_collection = star_collection; end
  def add_ship(ship); @ships << ship; end

  # Can obfuscate as much as we like
  def data
    {:stars => @star_collection.stars, :ships => @ships}
  end

end
