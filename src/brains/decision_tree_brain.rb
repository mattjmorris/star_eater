require "ai4r"

class DecisionTreeBrain
  def initialize
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

end