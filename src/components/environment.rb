class Environment
  attr_accessor :width, :height
  attr_reader :stars, :ships
  
  def initialize(params = {})
    @width = params[:size_x] || 600
    @height = params[:size_y] || 800
    @stars = []
    @ships = []
  end

  def add_element(object)
    if (object.is_a?(Star))
      @stars << object
    elsif(object.is_a?(Ship))
      @ships << object
    end
  end

end
