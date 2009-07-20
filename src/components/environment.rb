class Environment
  attr_accessor :width, :height
  attr_reader :stars, :ships, :star_collection
  
  def initialize(params = {})
    @width = params[:size_x] || 600
    @height = params[:size_y] || 800
    @stars = []
    @ships = []
  end

  # run after environment variables have been created
  def finalize
    @star_collection = StarFactory.get_simple_star_collection(self)
  end

  def add_star(star); @stars << star; end
  def add_ship(ship); @ships << ship; end

end
