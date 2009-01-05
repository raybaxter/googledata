module GCal
  
  class Event < Atom::Container
    NAMESPACES =  %w[ atom:http://www.w3.org/2005/Atom 
                      opensearch:http://a9.com/-/spec/opensearchrss/1.0/
                      gcal:http://schemas.google.com/gCal/2005
                      gd:http://schemas.google.com/gd/2005
                    ]
                    
    ELEMENTS = {
      :atom_id          => { :xpath => '//atom:entry/atom:id'},
      :edit_link        => { :type => :compound, :xpath => '//atom:$CONTAINER$/atom:link[@rel=\"edit\"]', :attribute => "href"},
      :comments         => { :xpath => '//atom:entry/gd:comments'},
      :comments_feedlink=> { :type => :compound, :xpath => '//atom:entry/gd:comments/gd:feedLink',  :attribute => "href"},
      :eventStatus      => { :type => :compound, :xpath => '//atom:entry/gd:eventStatus', :attribute => "value"},
      :visibility       => { :type => :compound, :xpath => '//atom:entry/gd:visibility', :attribute => "value"},
      
    }
    
    def elements_for_accessors
      super.merge(ELEMENTS)
    end
    
    def container_for_accessors
      'entry'
    end
        
  end
  
end