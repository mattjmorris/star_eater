
require File.dirname(__FILE__) + "/position"
require File.dirname(__FILE__) + "/velocity"
require File.dirname(__FILE__) + "/vector"

NUM_SHIPS = 1
NUM_STARS = 5
ships = []
stars = []

class Star
  attr_reader :position, :reward
  attr_writer :diameter

  def initialize (max_x, max_y, diameter = 15)
    @max_x = max_x - diameter / 2.to_f
    @max_y = max_y - diameter / 2.to_f
    @diameter = diameter
    @position = Position.new(rand * max_x, rand * max_y)
    @reward = rand * 100
  end

  def eaten(postion)
    if @position.nearby? @diameter, position
      @position = Position.new(rand * @max_x, rand * @max_y)
      return @reward
    end
  end

end

class Ship
  MAX_SPEED = 20

  attr_reader :velocity, :position, :diameter
  attr_writer :stars

  def initialize(position, velocity, stars)
    @position = position
    @velocity = velocity
    @stars = stars
    @diameter = 20
  end

  def move
    closest_star = (@stars.sort{|a, b| @position.distance(a.position) <=> @position.distance(b.position)}).first
    @velocity = Velocity.new(@position.get_vector_to(closest_star.position), MAX_SPEED)
    @position = @position.move(@velocity)
  end

end


Shoes.app(:title => "Star Hunter", :height => 600, :width => 800) do
  stroke rgb(0x30, 0x30, 0x05, 0.5)

  NUM_STARS.times { |i| stars[i] = Star.new(self.width, self.height) }
  NUM_SHIPS.times { |i| ships[i] = Ship.new(Position.new(self.width/2.to_f, self.height/2.to_f), Velocity.new_with_xy(0, 0), stars)}

  animate(24) do
    clear do
      background rgb(0xFF, 0xFF, 0xFF)

      ships.each do |ship|
        ship.stars = stars # updated set of stars
        ship.move

        draw_ship(ship)

        # TODO - have a star_collection that takes position of ship and returns reward, if any
        stars.each do |star|
          star.eaten(ship.position)
        end

      end

      stars.each do |star|
        draw_star(star)
      end

    end
  end


  def draw_ship(ship)
    debug("drawing the ship")
    fill rgb(0x30, 0xFF, 0xFF, 0.5)
    oval :left => ship.position.x, :top => ship.position.y, :width => ship.diameter, :center => true
    line ship.position.x, ship.position.y, (ship.position.x + ship.velocity.x), (ship.position.y + ship.velocity.y)
  end

  def draw_star(star)
    fill(rgb(0xFF, 0xFF, 0x30, 0.4))
    oval(:left => star.position.x, :top => star.position.y, :width => @size, :center => true)
  end

end

