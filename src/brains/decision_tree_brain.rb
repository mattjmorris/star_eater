require "ai4r"

class DecisionTreeBrain
  def initialize
<<<<<<< HEAD:src/brains/decision_tree_brain.rb
    @data_labels = ["Value Group", "Worthy Target"]
    @data_items = []
    @target = {:id => nil, :position => nil}
    @ticks_to_target = 0
    @group_divisions = 5
    @group_success_cutoff = 2
  end

  def set_data(data, count)
    @data = data
    @ticks_to_target += 1
    @ship_position = @data[:ship_position]
    analyze_target_situation
  end

  def next_velocity
    velocity = Velocity.new(Vector.new((@target[:position].x - @ship_position.x), (@target[:position].y - @ship_position.y)))
    velocity
  end

  private

  def get_next_target
    if (@data_items.length > 20)
      @target = get_decision_tree_next_target
    else
      @target = nearest_star
    end

  end

  def get_decision_tree_next_target
    analyze_id3
    p @id3.eval([5, 2])
    exit
  end

  def analyze_target_situation
    if @data[:star_id_delivering_reward] && @data[:star_id_delivering_reward] == @target[:id]
      add_target_to_data_items
      @target = {:id => nil, :position => nil}
      @ticks_to_target = 0
    end
    get_next_target unless @target[:position] && @target[:id]
  end

  def analyze_id3
    data_set = Ai4r::Data::DataSet.new(:data_items=>@data_items, :data_labels=>@data_labels)
    @id3 = Ai4r::Classifiers::ID3.new.build(data_set)
  end

  def add_target_to_data_items
    value_per_tick = (@data[:reward] / @ticks_to_target.to_f)
    group = (value_per_tick / (10/@group_divisions)).ceil
    @data_items << [group, (group>=@group_success_cutoff)?1:0]
  end

  def nearest_star
    target = nil
    @data[:star_position_hash].each{|id, pos| target = {:id => id, :position => pos} if target.nil? || @ship_position.distance(pos) < @ship_position.distance(target[:position])}
    target || {:id => nil, :position => @ship_position}
  end
=======
    @data_labels = ["Ticks", "Color", "Reward", "Value Group"]
    @data_items = []
  end

  def next_velocity(ship)
    return get_decition_tree_next_velocity(ship) if @data_items.length > 20

    verify_target

    Velocity.new(ship.position.get_vector_to(@target))

  end

  private

  def verify_target
    if @target.nil? || !star_at_position(@target)
      @target = @ship.star_position_hash[rand(@ship.star_position_hash.length)]
      
    end
  end
  
  def star_at_position(position)
    @ship.star_position_hash.detect{|key,value| value == position }
  end

  def get_decision_tree_next_velocity(ship)
    
  end  
  
  def analyze
    data_set = DataSet.new(:data_items=>@data_items, :data_labels=>@data_labels)
    id3 = Ai4r::Classifiers::ID3.new.build(data_set)
    id3.get_rules
    id3.eval(['New York', '<30', 'M'])
  end

  def add_star_to_data_items(star)
    
  end  
>>>>>>> fffd8f65f94df4f3aad1ec0f694f3eb9052b13f0:src/brains/decision_tree_brain.rb

end