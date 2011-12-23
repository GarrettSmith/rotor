require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'manager'

class ExampleManager < Manager
end

describe Manager do

  it "should provide a symbol of its class as a key" do
    @man = ExampleManager.new
    @man.key.should == :ExampleManager
  end
end
