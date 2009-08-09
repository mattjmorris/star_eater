require File.dirname(__FILE__) + "/game"

NUM_STARS = 3
SIZE_X = 800
SIZE_Y = 600

Shoes.app(:title => "Star Hunter", :height => SIZE_Y, :width => SIZE_X) do
  stroke rgb(0x30, 0x30, 0x05, 0.5)

  brain_type = :reinforcement

  game = Game.new(:size_x => SIZE_X, :size_y => SIZE_Y, :num_stars => NUM_STARS, :brain => brain_type)

  animate(30) do
    clear do
      background rgb(0xFF, 0xFF, 0xFF)

      game.tick

      draw_ship(game.environment.ship_position, game.ship.diameter)
      draw_stars(game.environment.star_collection.stars)

      draw_info

    end
  end

  def draw_ship(ship_position, ship_diameter)
    fill rgb(0x30, 0xFF, 0xFF, 0.5)
    oval :left => ship_position.x, :top => ship_position.y, :width => ship_diameter, :center => true
    #line ship_position.x, ship_position.y, (ship_position.x + ship.velocity.x), (ship_position.y + ship.velocity.y)
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

  def draw_info
    # HACK by MJM to get names of colors to show up on screen.
    nums_to_colors = {"1020102" => "purple", "2552550" => "yellow", "00255" => "blue", "01920" => "green", "25500" => "red"}
    stack do
      star_info = ""
      if $GAME_INFO[:star_info_hash]
        $GAME_INFO[:star_info_hash].each do |k,v|
          star_info += nums_to_colors[@ids_to_colors[k].to_s] + " => " + v + " | "
        end
      end
      para star_info, :stroke => blue, :margin => 1
      info = ""
      info += "tick count: #{$GAME_INFO[:tick_count]}" if $GAME_INFO[:tick_count]
      info += " | ship bank: #{$GAME_INFO[:ship_bank]}" if $GAME_INFO[:ship_bank]
      para info, :stroke => orange, :margin => 1
    end
  end

end

