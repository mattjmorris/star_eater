class Environment
  attr_accessor :width, :height
  attr_reader :stars, :ships
  
  def initialize(width=0, height=0)
    @width, @height = width, height
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
