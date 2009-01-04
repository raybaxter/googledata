require 'spec/spec_helper'
require 'spec/lib/atom/common_elements'

describe "Atom::Element" do
  before(:each) do
    @feed = Atom::Element.file('spec/fixtures/feeds/smallcalendars.xml')
  end

  it_should_behave_like "common Atom elements"
  
  it "should catch method missing errors and raise reasonable errors for debugging" do
    @message = nil
    @error = begin
        @feed.element_does_not_exist!
        false
      rescue UnknownAttribute => e
        @message = e.message
        true
      end 
    @error.should be_true
    @message.should == "Method: element_does_not_exist! - does not exist in scope"  
  end

  describe "metadata" do
    describe "category" do
      before(:each) do
        @events_feed = Atom::Element.file('spec/fixtures/feeds/calendar.maven.xml')
      end

      it "should have a #category" do
        @events_feed.category.should_not be_nil
      end

      it "should have a #category_term" do
        @events_feed.category_term.should == 'http://schemas.google.com/g/2005#event'
      end

      it "should have a #category_scheme" do
        @events_feed.category_scheme.should == 'http://schemas.google.com/g/2005#kind'
      end

      it "should have a #category_label" do
        @events_feed.category_label.should be_nil
        Atom::Element.file('spec/fixtures/feeds/synthetic.xml').category_label.should == 'Events'
      end

    end

    describe "#generator" do
      before(:each) do
        @events_feed = Atom::Element.file('spec/fixtures/feeds/calendar.maven.xml')
      end

      it "should have a #generator" do
        @events_feed.generator.should == 'Google Calendar'
      end

      it "should have #generator_uri" do
        @events_feed.generator_uri.should == 'http://www.google.com/calendar'
      end

      it "should have #version" do
        @events_feed.generator_version.should == "1.0"
      end

    end

    describe "#published" do
      it "should have a publication date" do
        Atom::Element.file('spec/fixtures/feeds/synthetic.xml').published.should == '2008-07-10T07:15:25.000Z'
      end
    end

  end
  
end
  
