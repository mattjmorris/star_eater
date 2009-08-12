require File.dirname(__FILE__) + "/game"
require 'rubygems'
require 'logging'

class NonGuiRunner

  def initialize
    @logger_info =
    [
            #:tick_count,
            #:ship_position,
            #:ship_velocity,
            #:ship_bank,
            :star_eaten,
            :star_reward,
            #:star_info_hash,
            :action_info
    ]
    $LOGGER = Logging.logger(STDOUT, :pattern => "%m\n", :date_pattern => "")
    $LOGGER.level = :debug
  end

  def run_game

    brains = [:ReinforcementBrain]

    brains.each do |brain|

      @game = Game.new(:size_x => 800, :size_y => 600, :num_stars => 3, :brain => brain)
      @tick_count = 0

      200.times do
        @tick_count += 1
        @game.tick
        show_log_info
      end
      
      puts "*" * 50
      puts "Brain #{brain.to_s} accumulated #{@game.ship.bank} points"
      puts "*" * 50
    end 
  end

  private

  def show_log_info

    $LOGGER.info("tick count = #{$GAME_INFO[:tick_count]}") if @logger_info.include?(:tick_count) and $GAME_INFO[:tick_count]
    $LOGGER.info("star info = #{$GAME_INFO[:star_info_hash]}") if @logger_info.include?(:star_info_hash) and $GAME_INFO[:star_info_hash]
    $LOGGER.info("action info = #{$GAME_INFO[:action_info]}") if @logger_info.include?(:action_info) and $GAME_INFO[:action_info]
    $LOGGER.info("ship velocity = #{$GAME_INFO[:ship_velocity]}") if @logger_info.include?(:ship_velocity) and $GAME_INFO[:ship_velocity]
    $LOGGER.info("ship position = #{$GAME_INFO[:ship_position]}") if @logger_info.include?(:ship_position) and $GAME_INFO[:ship_position]
    $LOGGER.info("ship bank = #{$GAME_INFO[:ship_bank]}") if @logger_info.include?(:ship_bank) and $GAME_INFO[:ship_bank]
    $LOGGER.info("star eaten id = #{$GAME_INFO[:star_eaten]}") if @logger_info.include?(:star_eaten) and $GAME_INFO[:star_eaten]
    $LOGGER.info("star reward = #{$GAME_INFO[:star_reward]}") if @logger_info.include?(:star_reward) and $GAME_INFO[:star_reward]


    # reset all GAME INFO to nil so old info doesn't stick around for next tick
    $GAME_INFO.each_key {|k| $GAME_INFO[k] = nil}
    
  end

end

NonGuiRunner.new.run_game

