require File.dirname(__FILE__) + '/../spec_helper'

describe CalendarFeed do
  before(:all) do
    @calendar_feed = CalendarFeed.file('spec/fixtures/feeds/calendar.maven.xml')
  end
  it "should inherit from Element" do
    CalendarFeed.superclass.should == Atom::Container
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
      @calendar_feed.category.should_not be_nil
      @calendar_feed.category_scheme.should == 'http://schemas.google.com/g/2005#kind'
      @calendar_feed.category_term.should == 'http://schemas.google.com/g/2005#event'
    end
    
    it "should have #subtitle" do
      @calendar_feed.subtitle.should == 'Calendar Maven'
    end
    
    it "should have #links" do
      @calendar_feed.links.size.should == 5
    end

    describe "author" do
      it "should have #author" do
        @calendar_feed.author.should_not be_nil
      end
    
      it "should have #author_name" do
        @calendar_feed.author_name.should == "Calendar Maven"
      end
    
      it "should have #author_email" do
        @calendar_feed.author_email.should == "calendar.maven@gmail.com"
      end
    end

     it "should have #generator" do
       @calendar_feed.generator.should == "Google Calendar"
     end

     it "should have #entries" do
       @calendar_feed.entries.size.should == 12
     end
     
    describe "links" do
      it "should have an #alternate_link" do
        @calendar_feed.alternate_link.should == 'http://www.google.com/calendar/embed?src=calendar.maven@gmail.com'
      end
      
      it "should have a #feed_link" do
        @calendar_feed.feed_link.should == 'http://www.google.com/calendar/feeds/calendar.maven%40gmail.com/private/full'
      end

      it "should have a #post_link" do
        @calendar_feed.post_link.should == 'http://www.google.com/calendar/feeds/calendar.maven%40gmail.com/private/full'
      end

      it "should have a #batch_link" do
        @calendar_feed.batch_link.should == 'http://www.google.com/calendar/feeds/calendar.maven%40gmail.com/private/full/batch'
      end
      
      it "should have a #self_link" do
        @calendar_feed.self_link.should == 'http://www.google.com/calendar/feeds/calendar.maven%40gmail.com/private/full?max-results=25'
      end
      
    end 

    #  <openSearch:totalResults>12</openSearch:totalResults>

    #  <openSearch:startIndex>1</openSearch:startIndex>

    #  <openSearch:itemsPerPage>25</openSearch:itemsPerPage>

    #  <gCal:timezone value='America/Los_Angeles' />

    #  <gCal:timesCleaned value='0' />
  end
  
  
  
end