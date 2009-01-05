module GCal
  class CalendarsFeed < Atom::Container
    NAMESPACES =  %w[ atom:http://www.w3.org/2005/Atom 
                      opensearch:http://a9.com/-/spec/opensearchrss/1.0/
                      gcal:http://schemas.google.com/gCal/2005
                      gd:http://schemas.google.com/gd/2005
                    ]
      
    attr_accessor :calendar_feeds
  
    def initialize(xml_string)
      super
      @calendar_feeds = entries.collect { |e| CalendarFeed.new(e) }
    end
  end
end
