require 'spec/spec_helper'

describe Atom::Container do
  before(:all) do
    @feed = Atom::Container.file('spec/fixtures/feeds/smallcalendars.xml')
  end
  
  it "should have a default namespace of atom" do
    # @feed.namespaces.namespace.should == LibXML::XML::Namespace.new(LibXML::XML::Node.new("stuff"),'','http://www.w3.org/2005/Atom')
  end
  
  describe "basic atom elements" do
    before(:all) do
      @feed = Atom::Container.file("spec/fixtures/feeds/smallcalendars.xml")
    end

    it "should have a #title for the feed" do
      @feed.title.should == "Calendar Maven's Calendar List"
    end

    it "should have a #subtitle for the feed if one is defined" do
      @feed.subtitle.should == ''
    end

    it "should have an #atom_id" do
       @feed.atom_id.should == 'http://www.google.com/calendar/feeds/default/allcalendars/full'
    end
   
    it "should have an #updated" do
      @feed.updated.should == '2008-09-01T05:24:24.549Z'
    end
    
    it "should have #links" do
      @feed.links.size.should == 4
    end
    
    describe "author" do
      it "should have author" do
        @feed.author.should_not be_nil
        @feed.author.should == %(Calendar Maven\n    calendar.maven@gmail.com)
      end
    
      it "should have author_name" do
        @feed.author_name.should == "Calendar Maven"
      end
    
      it "should have author_email" do
        @feed.author_email.should == "calendar.maven@gmail.com"
      end
    end
    
    it "should have #generator" do
      @feed.generator.should == "Google Calendar"
    end
    
    it "should have #entries" do
      @feed.entries.size.should == 1
    end
    
  end
   
  describe "links" do
    before(:all) do
      @feed = Atom::Container.file("spec/fixtures/feeds/smallcalendars.xml")
    end

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
   
   
end
  
