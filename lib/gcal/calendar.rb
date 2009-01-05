module GCal
  class Calendar < Atom::Container
  
    ELEMENTS = {
      :batch_link       => {:type => :compound, :xpath => '//atom:feed/atom:link[@rel=\"http://schemas.google.com/g/2005#batch\"]', :attribute => "href"},
      :totalResults     => {:xpath => '//atom:feed/openSearch:totalResults'},
      :startIndex       => {:xpath => '//atom:feed/openSearch:startIndex'},
      :itemsPerPage     => {:xpath => '//atom:feed/openSearch:itemsPerPage'},
      :timezone_value   => {:type => :compound, :xpath => '//atom:feed/gCal:timezone', :attribute => 'value'},
    }
    
    def elements_for_accessors
      super.merge(ELEMENTS)
    end
    
  end

end