require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'hash'

describe Hash do
  
  describe "<<" do

    before do
      @obj = mock("Object")
      @hash = Hash.new
    end

    it "should add obj if the given obj supplies a key" do
      @obj.stub!(:key).and_return("Example")
      @hash << @obj
      @hash[@obj.key].should == @obj
    end

    it "should raise error if obj does not supply a key" do
      proc do
        @hash << @obj
      end.should raise_error(ArgumentError, 
                             "object does not respond to key")
    end
  end
end
