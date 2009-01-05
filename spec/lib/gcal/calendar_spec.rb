require File.dirname(__FILE__) + '/../../spec_helper'

describe GCal::Calendar do
  before(:all) do
    @calendar = GCal::Calendar.file('spec/fixtures/feeds/calendar.maven.xml')
  end

  it "should inherit from Element" do
    GCal::Calendar.superclass.should == Atom::Container
  end
    
  describe "Atom properties" do
    it "should have #atom_id" do
      @calendar.atom_id.should == 'http://www.google.com/calendar/feeds/calendar.maven%40gmail.com/private/full'
    end
    
    it "should have #updated" do
      @calendar.updated.should == '2008-07-18T05:44:51.000Z'
    end
    
    it "should have #title" do
      @calendar.title.should == 'Calendar Maven'
    end
    
    it "should have #category" do
      @calendar.category.should_not be_nil
      @calendar.category_scheme.should == 'http://schemas.google.com/g/2005#kind'
      @calendar.category_term.should == 'http://schemas.google.com/g/2005#event'
    end
    
    it "should have #subtitle" do
      @calendar.subtitle.should == 'Calendar Maven'
    end
    
    it "should have #links" do
      @calendar.links.size.should == 5
    end

    describe "author" do
      it "should have #author" do
        @calendar.author.should_not be_nil
      end
    
      it "should have #author_name" do
        @calendar.author_name.should == "Calendar Maven"
      end
    
      it "should have #author_email" do
        @calendar.author_email.should == "calendar.maven@gmail.com"
      end
    end

     it "should have #generator" do
       @calendar.generator.should == "Google Calendar"
     end

     it "should have #entries" do
       @calendar.entries.size.should == 12
     end
     
    describe "links" do
      it "should have an #alternate_link" do
        @calendar.alternate_link.should == 'http://www.google.com/calendar/embed?src=calendar.maven@gmail.com'
      end
      
      it "should have a #feed_link" do
        @calendar.feed_link.should == 'http://www.google.com/calendar/feeds/calendar.maven%40gmail.com/private/full'
      end

      it "should have a #post_link" do
        @calendar.post_link.should == 'http://www.google.com/calendar/feeds/calendar.maven%40gmail.com/private/full'
      end

      it "should have a #batch_link" do
        @calendar.batch_link.should == 'http://www.google.com/calendar/feeds/calendar.maven%40gmail.com/private/full/batch'
      end
      
      it "should have a #self_link" do
        @calendar.self_link.should == 'http://www.google.com/calendar/feeds/calendar.maven%40gmail.com/private/full?max-results=25'
      end
      
    end 
    
    describe "openSearch namespace" do
      it "should have #totalResults" do
        @calendar.totalResults.should == '12'        
      end
      
      it "should have #startIndex" do
        @calendar.startIndex.should == '1'
      end

      it "should have #itemsPerPage" do
        @calendar.itemsPerPage.should == '25'
      end
      
    end

    describe "gCal namespace" do
      it "should have #timezone_value" do
        @calendar.timezone_value.should == 'America/Los_Angeles'
        
      end
    end

    #  <gCal:timesCleaned value='0' />
  end
  
end