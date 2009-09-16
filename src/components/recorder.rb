require 'csv'

class Recorder

  def initialize(label)
    @ticks = []
    @label = label
  end

  def write()
    CSV.open("results_#{@label}_#{Time.now.strftime("%Y%m%d-%H%M%S")}.csv", 'w') do |writer|
      writer << ["Tick","Reward","Star ID"]
      @ticks.each_with_index do |tick, index|
        writer << [index, tick[0], tick[1]]
      end
    end
  end

  def write_avg_reward(window_size = 100)

    window_sum = 0
    window_avgs = []
    count = 0
    @ticks.each_with_index do |tick, index|
      count += 1
      window_sum += tick[0]
      if (index + 1) % window_size == 0
        window_avgs << [index + 1, window_sum.to_f / count]
        window_sum = 0
        count = 0
      end
    end

    CSV.open("results_#{@label}_#{Time.now.strftime("%Y%m%d-%H%M%S")}.csv", 'w') do |writer|
      window_avgs.each do |avg|
        writer << [avg[0], avg[1]]
      end
    end
  end  

  def add(reward, star_id)
    @ticks << [reward, star_id]
  end

end