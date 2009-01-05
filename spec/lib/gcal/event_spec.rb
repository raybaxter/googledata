require File.dirname(__FILE__) + '/../../spec_helper'

describe GCal::Event do
  it "should read an event" do
    GCal::Event.file('spec/fixtures/feeds/event.xml').should_not be_nil
  end

  describe "Atom properties" do
    before(:all) do
      @event = GCal::Event.file('spec/fixtures/feeds/event.xml')
    end
    
    it "should have #atom_id" do
      @event.atom_id.should == 'http://www.google.com/calendar/feeds/default/events/upd56n8tetsuor73bas6v923ek'
    end
    
    it "should have #title" do
      @event.title.should == 'Time Zone Test'
    end
    
    it "should have #content" do
      @event.content.should == 'Hi mom!'
    end
    
    it "should have #published" do
      @event.published.should == '2008-05-31T00:41:07.000Z'
    end
    
    it "should have #updated" do
      @event.updated.should == '2008-05-31T00:41:07.000Z'
    end
    
    it "should have #category_scheme" do
      @event.category_scheme.should == 'http://schemas.google.com/g/2005#kind'
    end
    
    it "should have #category_term" do
      @event.category_term.should == 'http://schemas.google.com/g/2005#event'
    end
    
    it "should have #links" do
      @event.links.size.should == 3
    end

    describe "author" do
      it "should have author" do
        @event.author.should_not be_nil
        @event.author.should == %(Calendar Maven\n    calendar.maven@gmail.com)
      end

      it "should have author_name" do
        @event.author_name.should == "Calendar Maven"
      end

      it "should have author_email" do
        @event.author_email.should == "calendar.maven@gmail.com"
      end
    end

  end
  
  # <app:edited xmlns:app='http://www.w3.org/2007/app'>
  # 2008-05-31T00:41:07.000Z</app:edited>

  describe "links" do
    before(:all) do
      @event = GCal::Event.file('spec/fixtures/feeds/event.xml')
    end
    
    it "should have an #alternate_link" do
      @event.alternate_link.should == 'http://www.google.com/calendar/event?eid=dXBkNTZuOHRldHN1b3I3M2JhczZ2OTIzZWsgY2FsZW5kYXIubWF2ZW5AbQ'
    end
    
    it "should have a #self_link" do
      @event.self_link.should == 'http://www.google.com/calendar/feeds/default/private/full/upd56n8tetsuor73bas6v923ek?v=2'
    end
    
    it "should have an #edit_link" do
      @event.edit_link.should == 'http://www.google.com/calendar/feeds/default/private/full/upd56n8tetsuor73bas6v923ek?v=2'  
    end
    
  end
  
  describe "gd namespace properties" do
    before(:all) do
      @event = GCal::Event.file('spec/fixtures/feeds/event.xml')
    end
    
    it "should have #comments" do
      @event.comments.should == ''
    end
    
    it "should have #comments_feedlink" do
      @event.comments_feedlink.should == 'http://www.google.com/calendar/feeds/default/private/full/upd56n8tetsuor73bas6v923ek/comments?v=2'
    end
    
    it "should have #eventStatus" do
      @event.eventStatus.should == 'http://schemas.google.com/g/2005#event.confirmed'
    end

    it "should have #visibility" do
      @event.visibility.should == 'http://schemas.google.com/g/2005#event.default'
    end
    
    xit "should have #transparency" do
      @event.transparency.should == 'http://schemas.google.com/g/2005#event.opaque'
    end


    # <gd:transparency value='http://schemas.google.com/g/2005#event.opaque' />
    # <gd:when startTime='2008-05-30T10:00:00.000-07:00'
    # endTime='2008-05-30T10:01:00.000-07:00'>
    #   <gd:reminder minutes='10' method='alert' />
    # </gd:when>
    # <gd:who rel='http://schemas.google.com/g/2005#event.organizer'
    # valueString='Calendar Maven' email='calendar.maven@gmail.com' />
    # <gd:where />

    
  end

  # <gCal:uid value='upd56n8tetsuor73bas6v923ek@google.com' />
  # <gCal:sequence value='0' />
  
  
end