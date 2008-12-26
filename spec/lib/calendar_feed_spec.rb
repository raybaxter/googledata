require File.dirname(__FILE__) + '/../spec_helper'

describe CalendarFeed do
  before(:all) do
    @calendar_feed = CalendarFeed.file('spec/fixtures/feeds/calendar.maven.xml')
  end
  it "should inherit from Element" do
    CalendarFeed.superclass.should == AtomFeed
  end
    
  describe "Atom properties" do
    it "should have #atom_id" do
      @calendar_feed.atom_id.should == 'http://www.google.com/calendar/feeds/calendar.maven%40gmail.com/private/full'
    end
    
    it "should have #updated" do
      @calendar_feed.updated.should == '2008-07-18T05:44:51.000Z'
    end
    
    it "should have #title" do
      @calendar_feed.title.should == 'Calendar Maven'
    end
    
    it "should have #category" do
      #  <category scheme='http://schemas.google.com/g/2005#kind'
      #  term='http://schemas.google.com/g/2005#event' />
      
      pending("Needs to be written")
    end
    
    it "should have #subtitle" do
      @calendar_feed.subtitle.should == 'Calendar Maven'
    end
    
    it "should have #links" do
      @calendar_feed.links.size.should == 5
    end

    describe "author" do
      it "should have author" do
        @calendar_feed.author.should_not be_nil
        @calendar_feed.author.should == Author.new(@calendar_feed.author_name, @calendar_feed.author_email)
      end

      it "should have author_name" do
        @calendar_feed.author_name.should == "Calendar Maven"
      end

      it "should have author_email" do
        @calendar_feed.author_email.should == "calendar.maven@gmail.com"
      end
     end

     it "should have #generator" do
       @calendar_feed.generator.should == "Google Calendar"
     end

     it "should have #entries" do
       @calendar_feed.entries.size.should == 12
     end
     
     
    #  <link rel='alternate' type='text/html'
    #  href='http://www.google.com/calendar/embed?src=calendar.maven@gmail.com' />
    #  <link rel='http://schemas.google.com/g/2005#feed'
    #  type='application/atom+xml'
    #  href='http://www.google.com/calendar/feeds/calendar.maven%40gmail.com/private/full' />
    #  <link rel='http://schemas.google.com/g/2005#post'
    #  type='application/atom+xml'
    #  href='http://www.google.com/calendar/feeds/calendar.maven%40gmail.com/private/full' />
    #  <link rel='http://schemas.google.com/g/2005#batch'
    #  type='application/atom+xml'
    #  href='http://www.google.com/calendar/feeds/calendar.maven%40gmail.com/private/full/batch' />
    #  <link rel='self' type='application/atom+xml'
    #  href='http://www.google.com/calendar/feeds/calendar.maven%40gmail.com/private/full?max-results=25' />

    #  <openSearch:totalResults>12</openSearch:totalResults>
    #  <openSearch:startIndex>1</openSearch:startIndex>
    #  <openSearch:itemsPerPage>25</openSearch:itemsPerPage>
    #  <gCal:timezone value='America/Los_Angeles' />
    #  <gCal:timesCleaned value='0' />
  end
  
  
  
end