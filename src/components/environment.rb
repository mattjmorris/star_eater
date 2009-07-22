class Environment
  attr_accessor :width, :height

  def initialize(params = {})
    @width = params[:size_x] || 600
    @height = params[:size_y] || 800
    @stars = []
    @ships = []
  end

  def add_star(star); @stars << star; end
  def add_ship(ship); @ships << ship; end

  # Can obfuscate as much as we like
  def data
    {:stars => @stars, :ships => @ships}
  end

end
