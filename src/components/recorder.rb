require 'csv'

class Recorder

  def initialize(label)
    @ticks = []
    @label = label
  end

  def write()
    file_name = "results_#{@label}_#{Time.now.strftime("%Y%m%d-%H%M%S")}.csv"
    CSV.open(file_name, 'w') do |writer|
      writer << ["Tick","Reward","Star ID"]
      @ticks.each_with_index do |tick|
        writer << tick
      end
    end
    puts
    p "wrote data file: #{file_name}"
  end

  def tick(tick_count, env)
    @ticks << [tick_count, env.reward, env.star_id_delivering_reward] if env.star_id_delivering_reward
  end

end