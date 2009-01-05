module GCal
  class Calendars < Atom::Container
    NAMESPACES =  %w[ atom:http://www.w3.org/2005/Atom 
                      opensearch:http://a9.com/-/spec/opensearchrss/1.0/
                      gcal:http://schemas.google.com/gCal/2005
                      gd:http://schemas.google.com/gd/2005
                    ]
      
    attr_accessor :calendars
  
    def initialize(xml_string)
      super
      @calendars = entries.collect { |e| Calendar.new(e) }
    end
  end
end
