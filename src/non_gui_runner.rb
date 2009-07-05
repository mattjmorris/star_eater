require File.dirname(__FILE__) + "/game"
require 'rubygems'
require 'logging'

class NonGuiRunner

  def initialize
    # TODO: configure logger to show tick count rather than current time.
    @logger = Logging.logger(STDOUT, :pattern => "%-5l: %m\n", :date_pattern => "")    
    @logger.level = :debug
    @game = Game.new(:size_x => 800, :size_y => 600, :num_stars => 1)
    @game.add_observer(self)
    @tick_count = 0
  end

  def update(msg, level)
    # TODO - call logger method based on level
    @logger.info("#{@tick_count}:\t #{msg}")
  end

  def run_game
    100.times do
      @tick_count += 1
      @game.tick
    end
  end

end

NonGuiRunner.new.run_game

