describe "common Atom elements", :shared => true do  
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

