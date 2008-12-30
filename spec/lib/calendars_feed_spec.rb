require File.dirname(__FILE__) + '/../spec_helper'

describe "#new" do
  it "should read a calendar" do
    CalendarsFeed.file("spec/fixtures/feeds/smallcalendars.xml").should_not be_nil
  end

  it "should be a subclass of AtomFeed" do
    CalendarsFeed.superclass.should == Atom::Container
  end
end

describe "basic atom elements" do
  before(:all) do
    @calendars = CalendarsFeed.file("spec/fixtures/feeds/smallcalendars.xml")
  end
  
  it "should have a #title for the feed" do
    @calendars.title.should == "Calendar Maven's Calendar List"
  end
  
  it "should have an #atom_id" do
    @calendars.atom_id.should == 'http://www.google.com/calendar/feeds/default/allcalendars/full'
  end
  
  it "should have an #updated" do
    @calendars.updated.should == '2008-09-01T05:24:24.549Z'
  end
  
  it "should have #links" do
    @calendars.links.size.should == 4
  end

  describe "author" do
    it "should have author" do
      pending "Author is composite"
      @calendars.author.should_not be_nil
      @calendars.author.should == Author.new(@calendars.author_name,@calendars.author_email)
    end
    
    it "should have author_name" do
      @calendars.author_name.should == "Calendar Maven"
    end
    
    it "should have author_email" do
      @calendars.author_email.should == "calendar.maven@gmail.com"
    end
  end
  
  it "should have #generator" do
    @calendars.generator.should == "Google Calendar"
  end
  
  it "should have #entries" do
    @calendars.entries.size.should == 1
  end

end

describe "GData Elements" do
  before(:all) do
    @calendars = CalendarsFeed.file("spec/fixtures/feeds/allcalendars.xml")
  end
  
  it "should have #calendar_feeds" do
    @calendars.calendar_feeds.size.should == 11
  end
  
end

describe "links" do
  before(:all) do
    @calendars = CalendarsFeed.file("spec/fixtures/feeds/smallcalendars.xml")
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