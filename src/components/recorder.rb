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

  def add(reward, star_id)
    @ticks << [reward, star_id]
  end

end