require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'scene'
require 'entity'

describe Scene do

  before :each do
    @scene = Scene.new
  end

  it "should remember a list of entities" do
    @scene = Scene.new
    entity1 = Entity.new
    entity2 = Entity.new
    @scene.entities << entity1
    @scene.entities << entity2
    @scene.entities.should == [entity1, entity2]
  end

end
