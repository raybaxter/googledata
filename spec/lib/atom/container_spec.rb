require 'spec/spec_helper'
require 'spec/lib/atom/common_elements'

describe Atom::Container do
  before(:all) do
    @feed = Atom::Container.file('spec/fixtures/feeds/smallcalendars.xml')
  end
  
  it "should have a default namespace of atom" do
    pending("This doesn't work") do
      # @feed.namespaces.namespace.should == LibXML::XML::Namespace.new(LibXML::XML::Node.new("stuff"),'','http://www.w3.org/2005/Atom')
      fail
    end
  end
  
  it_should_behave_like "common Atom elements"

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
  
  it "should have a #category" do
    events_feed = Atom::Container.file('spec/fixtures/feeds/calendar.maven.xml')
    events_feed.category.should_not be_nil
  end

  it "should have a #category_scheme" do
    events_feed = Atom::Container.file('spec/fixtures/feeds/calendar.maven.xml')
    events_feed.category_scheme.should == 'http://schemas.google.com/g/2005#kind'
  end

  it "should have a #category_term" do
    events_feed = Atom::Container.file('spec/fixtures/feeds/calendar.maven.xml')
    events_feed.category_term.should == 'http://schemas.google.com/g/2005#event'
  end
  
  it "should have a #subtitle" do
    events_feed = Atom::Container.file('spec/fixtures/feeds/calendar.maven.xml')
    events_feed.subtitle.should == 'Calendar Maven'
  end
  
   
end
  
