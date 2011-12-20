require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'scheduler'

describe Scheduler do
  
  it "should record the time it was started" do
    t = Time.parse("01/01/2010 10:00")
    2.times { Time.should_receive(:now).and_return(t) }
    @scheduler = Scheduler.new
    @scheduler.start_time.should == Time.now
  end
end
