require File.dirname(__FILE__) + "/game"
require 'rubygems'
require 'logging'

class NonGuiRunner

  def self.instance
    @@instance ||= self.new
    return @@instance
  end

  attr_reader :rewards_accumulated

  def run_game(params = {})

    params[:episode_length] ||= 1000
    params[:num_episodes] ||= 5
    params[:brain_types] ||= [:static_action_closest_star, :reinforcement, :genetic_algorithm, :decisiontree]
    params[:star_collection_types] ||= [:progressive]
    params[:num_stars] ||= 3
    params[:size_x] ||= 800
    params[:size_y] ||= 600

    collected_values = []

    params[:brain_types].each do |brain_type|

      params[:star_collection_types].each do |star_collection_type|

        recorder = Recorder.new("#{brain_type}_#{star_collection_type}")

        params[:num_episodes].times do

          @game = Game.new(params.merge({:brain_type => brain_type, :star_collection_type => star_collection_type, :recorder => recorder}))
          @tick_count = 0

          params[:episode_length].times do
            @tick_count += 1
            @game.tick
            #show_log_info
          end

          @rewards_accumulated = @game.environment.bank

          #puts "Brain type #{brain_type.to_s} accumulated #{@rewards_accumulated} points when running with star collection type #{star_collection_type} for #{params[:episode_length]} ticks"

          collected_values << @rewards_accumulated
          @game.environment.bank = 0
          
        end
        
        #recorder.write

      end

      sum = collected_values.inject{|a,b| a+b}
      puts "Brain type #{brain_type.to_s} had a total acheived = #{sum} for an average of #{sum / params[:num_episodes]}"
        
    end

  end

end

NonGuiRunner.instance.run_game

