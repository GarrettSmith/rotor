require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'state'
require 'entity'

describe State do
  
  before :each do
    @state = State.new
  end

  it "should remember a list of entities" do
    @entity1 = Entity.new(1)
    @entity2 = Entity.new(2)
    @state.entities << @entity1
    @state.entities << @entity2
    @state.entities.should == [@entity1, @entity2]
  end
end
