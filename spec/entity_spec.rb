require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'entity'

describe Entity do

  it "should have the given name" do
    @entity = Entity.new("Bob")
    @entity.name.should == "Bob"
  end

  it "should not have a name that was not given" do
    @entity = Entity.new("Jim")
    @entity.name.should_not == "Bob"
  end

  it "should have a unique number" do
    @entity1 = Entity.new("Bob")
    @entity2 = Entity.new("Fred")

    @entity1.number.should_not == @entity2.number
  end
end
