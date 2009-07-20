require File.dirname(__FILE__) + "/game"
require 'rubygems'
require 'logging'

class NonGuiRunner

  def initialize
    $D = true # set $D to true to have debug info printed out.
    $LOGGER = Logging.logger(STDOUT, :pattern => "%m\n", :date_pattern => "")
    $LOGGER.level = :debug
    @game = Game.new(:size_x => 800, :size_y => 600, :num_stars => 1)
    @tick_count = 0
  end

  def run_game
    100.times do
      @tick_count += 1
      @game.tick
    end
  end

end

NonGuiRunner.new.run_game

