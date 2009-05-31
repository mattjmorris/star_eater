require "spec"
require File.dirname(__FILE__) + "/../src/star_collection"
require File.dirname(__FILE__) + "/../src/util/extend_array"

describe StarCollection do

  # Called before each example.
  before(:each) do
    @num_stars = 5
    @star_collection = StarCollection.new
    @num_stars.times { @star_collection.stars << Star.new }
  end

  it "should hold a collection of stars" do
    @star_collection.stars.size.should be(@num_stars)
  end

  it "should return a 'position hash' that is a hash of ids and positions for just the visible stars" do
    star_ids = []
    @star_collection.stars.each { |star| star_ids << star.id }
    @star_collection.stars[1].visible = false
    @star_collection.stars[3].visible = false
    position_hash = @star_collection.position_hash
    position_hash.size.should be(@num_stars - 2)
    ids_of_invisible = []
    @star_collection.stars.each { |star| ids_of_invisible << star.id if !star.visible }
    ids_of_invisible.each { |id_to_delete| star_ids.delete_if { |id| id == id_to_delete } }
    position_hash.keys.same?(star_ids).should be(true)
    position_hash.values.each { |p| p.class.to_s.should == "Position" }
  end

end