require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'rotor'

describe Rotor do

  before do
    @rotor = Rotor.new
  end

  it "should remember a collection of scenes" do
    @scene1 = mock(:scene)
    @scene2 = mock(:scene)
    @rotor.scenes << @scene1
    @rotor.scenes << @scene2
    @rotor.scenes.should == [@scene1, @scene2]
  end

  it "should remember a collection of managers" do
    @manager1 = mock(:manager)
    @manager2 = mock(:manager)
    @rotor.managers << @manager1
    @rotor.managers << @manager2
    @rotor.managers.should == [@manager1, @manager2]
  end

  describe "Start up" do

    it "should create all managers"

    it "should create a scheduler"
  end

  describe "Game loop" do

    it "should process window events"

    it "should execute tasks"

    it "should distribute changes"

    it "should check execution status"
  end
end
