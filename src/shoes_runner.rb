require File.dirname(__FILE__) + "/game"

NUM_STARS = 1
SIZE_X = 600
SIZE_Y = 800

Shoes.app(:title => "Star Hunter", :height => SIZE_X, :width => SIZE_Y) do
  stroke rgb(0x30, 0x30, 0x05, 0.5)

  game = Game.new(SIZE_X, SIZE_Y, NUM_STARS)

  animate(1) do
    clear do
      background rgb(0xFF, 0xFF, 0xFF)

      game.tick

      draw_ship(game.ship)
      draw_stars(game.star_collection.stars)

      end
  end

  def draw_ship(ship)
    fill rgb(0x30, 0xFF, 0xFF, 0.5)
    oval :left => ship.position.x, :top => ship.position.y, :width => ship.diameter, :center => true
    line ship.position.x, ship.position.y, (ship.position.x + ship.velocity.x), (ship.position.y + ship.velocity.y)
  end

  def draw_stars(stars)
    stars.each do |star|
      next unless star.visible
      fill(rgb(0xFF, 0x30, 0xFF, 0.4))
      oval(:left => star.position.x, :top => star.position.y, :width => star.diameter, :center => true)
     end
  end

end

