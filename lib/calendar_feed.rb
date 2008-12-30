class CalendarFeed < Atom::Container
  
  LOCAL_ELEMENTS = {
    :batch_link       => {:type => :compound, :xpath => '//atom:feed/atom:link[@rel=\"http://schemas.google.com/g/2005#batch\"]', :attribute => "href"},
    }
  
  def local_elements
    Atom::Container::ELEMENTS.merge(LOCAL_ELEMENTS)
  end

end