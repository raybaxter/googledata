require 'spec/spec_helper'
require 'spec/lib/atom/common_elements'

describe Atom::Container do
  before(:all) do
    @feed = Atom::Container.file('spec/fixtures/feeds/smallcalendars.xml')
  end
  
  it_should_behave_like "common Atom elements"

  describe "links" do

    it "should have an alternate link" do
      @feed.alternate_link.should == 'http://www.google.com/calendar/render'
    end

    it "should have a feed link" do
      @feed.feed_link.should == 'http://www.google.com/calendar/feeds/default/allcalendars/full'
    end

    it "should have a post link" do
      @feed.post_link.should == 'http://www.google.com/calendar/feeds/default/allcalendars/full'
    end

    it "should have a self link" do
      @feed.self_link.should == 'http://www.google.com/calendar/feeds/default/allcalendars/full'
    end  
  end 
  
  it "should have a #subtitle" do
    events_feed = Atom::Container.file('spec/fixtures/feeds/calendar.maven.xml')
    events_feed.subtitle.should == 'Calendar Maven'
  end  
  
end
  
