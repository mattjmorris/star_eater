require File.dirname(__FILE__) + "/game"

NUM_STARS = 1
SIZE_X = 800
SIZE_Y = 600

Shoes.app(:title => "Star Hunter", :height => SIZE_Y, :width => SIZE_X) do
  stroke rgb(0x30, 0x30, 0x05, 0.5)

  game = Game.new(:size_x => SIZE_X, :size_y => SIZE_Y, :num_stars => NUM_STARS)

  # TODO - shoes app doesn't seem to be able to respond to update message from the subject (game).  Pass in
  # a logger that can log to a file?
  #game.add_observer(self)

  animate(30) do
    clear do
      background rgb(0xFF, 0xFF, 0xFF)

      game.tick

      game.environment.ships.each{|ship| draw_ship(ship)}
      draw_stars(game.environment.star_collection.stars)

      visibility_time = game.environment.star_collection.stars.first.visible_limit      
      star_info = "star is visible for #{visibility_time}"
      #draw_info(game.updates, star_info)

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
      r, g, b = get_star_color(star.id)
      fill(rgb(r, g, b, 0.4))
      left_pos = star.position.x - star.diameter / 2
      top_pos = star.position.y + star.diameter / 2
      oval(:left => star.position.x, :top => star.position.y, :width => star.diameter, :center => true)
     end
  end

  # maintain a different color for each star, so they can be individually identified
  def get_star_color(id)
    colors = {:red => [255, 0, 0], :green => [0, 192, 0], :blue => [0, 0, 255], :yellow => [255, 255, 0], :purple => [102, 0, 102]}
    (NUM_STARS-5).times {|i| colors["color#{i}"] = [rand(256), rand(256), rand(256)]}
    @ids_to_colors ||= {}
    @ids_to_colors[id] ||= colors[colors.keys[@ids_to_colors.size]]
    return @ids_to_colors[id]
  end

  def update(msg, level)
    stack do
      para msg, :stroke => orange, :margin => 1
      #para star_info, :stroke => red, :margin => 1
    end
  end

end

