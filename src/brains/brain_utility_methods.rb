# Depends on the following intance methods (for brevity)
#
# @ship_position : position of your ship

module BrainUtilityMethods

  def star_dist(star_position)
    Velocity.new(Vector.new(star_position.x - @ship_position.x, star_position.y - @ship_position.y)).magnitude
  end

  def velocity_to(position)
    Velocity.new(Vector.new((position.x - @ship_position.x), (position.y - @ship_position.y)))
  end

  def nearest_star(star_hash)
    target = nil
    star_hash.each{|id, pos| target = {:id => id, :position => pos} if target.nil? || star_dist(pos) < star_dist(target[:position])}
    target || raise("Could not find a star to target.")
  end

  def reward_given?() (@data[:star_id_delivering_reward] && @data[:star_id_delivering_reward] == @target[:id]); end
  
  def load_csv_array_with_labels(file_path)
    items = []; open_csv_file(file_path){|entry| items << entry}
    @data_labels = items.shift
    items
  end

  def write_labels_to_csv_file(file_path, labels)
    File.open(file_path, "w"){|f| f.puts labels.join(",")}
  end

  def write_array_result_to_csv_file(file_path, result)
    File.open(file_path, "a"){|f| f.puts result.join(",") }
  end

  def open_csv_file(filepath, &block)
    if CSV.const_defined? :Reader
      CSV::Reader.parse(File.open(filepath, 'r')) do |row|
        block.call row
      end
    else
      CSV.parse(File.open(filepath, 'r')) do |row|
        block.call row
      end
    end
  end
end