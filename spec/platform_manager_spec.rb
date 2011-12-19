require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'platform_manager'
require 'facter'

describe PlatformManager do

  before(:all) do
    Facter.loadfacts
  end

  before(:each) do
    @platform_manager = PlatformManager.new
  end

  it "should respond to all the fact methods of Facter" do
    Facter.collection.list.each do |fact|
      @platform_manager.should respond_to(fact)
    end
  end

  it "should return the same value as the equivalent Facter method" do
    Facter.collection.list.each do |fact| 
      @platform_manager.send(fact).should 
        eql(Facter.send(fact))
    end
  end
end
