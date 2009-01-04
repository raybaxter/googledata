class CalendarFeed < Atom::Container
  
  ELEMENTS = {
    :batch_link       => {:type => :compound, :xpath => '//atom:feed/atom:link[@rel=\"http://schemas.google.com/g/2005#batch\"]', :attribute => "href"},
  }
  
  def elements_for_accessors
    super.merge(ELEMENTS)
  end
  
end