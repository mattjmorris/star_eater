# Depends on the following intance methods (for brevity)
#
# @ship_position : position of your ship

module BrainUtilityMethods

  def star_dist(star_position)
    Velocity.new(Vector.new(star_position.x - @ship_position.x, star_position.y - @ship_position.y)).magnitude
  end

  def nearest_star(star_hash)
    target = nil
    star_hash.each{|id, pos| target = {:id => id, :position => pos} if target.nil? || star_dist(pos) < star_dist(target[:position])}
    target || raise("Could not find a star to target.")
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