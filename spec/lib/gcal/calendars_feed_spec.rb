require File.dirname(__FILE__) + '/../../spec_helper'
require 'spec/lib/atom/common_elements'
 
describe GCal::CalendarsFeed do
  before(:all) do
    @feed = GCal::CalendarsFeed.file("spec/fixtures/feeds/smallcalendars.xml")
  end

  it "should read a calendar" do
    GCal::CalendarsFeed.file("spec/fixtures/feeds/smallcalendars.xml").should_not be_nil
  end

  it "should be a subclass of AtomFeed" do
    GCal::CalendarsFeed.superclass.should == Atom::Container
  end
  
  it_should_behave_like "common Atom elements"  
  
end

describe "GData Elements" do
  before(:all) do
    @calendars = GCal::CalendarsFeed.file("spec/fixtures/feeds/allcalendars.xml")
  end
  
  it "should have #calendar_feeds" do
    @calendars.calendar_feeds.size.should == 11
  end
  
end

describe "links" do
  before(:all) do
    @calendars = GCal::CalendarsFeed.file("spec/fixtures/feeds/smallcalendars.xml")
  end
  
  it "should have an alternate link" do
    @calendars.alternate_link.should == 'http://www.google.com/calendar/render'
  end
  
  it "should have a feed link" do
    @calendars.feed_link.should == 'http://www.google.com/calendar/feeds/default/allcalendars/full'
  end
  
  it "should have a post link" do
    @calendars.post_link.should == 'http://www.google.com/calendar/feeds/default/allcalendars/full'
  end
  
  it "should have a self link" do
    @calendars.self_link.should == 'http://www.google.com/calendar/feeds/default/allcalendars/full'
  end  
end