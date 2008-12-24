class CalendarsFeed
  require 'rubygems'
  require 'libxml'
  # require 'libxml-ruby'
  NAMESPACES =  %w[ atom:http://www.w3.org/2005/Atom 
                    opensearch:http://a9.com/-/spec/opensearchrss/1.0/
                    gcal:http://schemas.google.com/gCal/2005
                    gd:http://schemas.google.com/gd/2005
                  ]
    
  def initialize(xml_string)
    parser = LibXML::XML::Parser.new
    parser.string = xml_string
    @doc = parser.parse
  end
  
  def title
   extract_content("//atom:feed/atom:title")
  end
  
  def atom_id
    extract_content("//atom:feed/atom:id")
  end
  
  def updated
    extract_content("//atom:feed/atom:updated")
  end
  
  def links
    extract("//atom:feed/atom:link")
  end
  
  def alternate_link
    extract("//atom:feed/atom:link[@rel='alternate']").first.attributes['href']
  end
  
  def feed_link
    extract("//atom:feed/atom:link[@rel='http://schemas.google.com/g/2005#feed']").first.attributes['href']    
  end
  
  def post_link
    extract("//atom:feed/atom:link[@rel='http://schemas.google.com/g/2005#post']").first.attributes['href']
  end
  
  def self_link
    extract("//atom:feed/atom:link[@rel='self']").first.attributes['href']
  end

  def author
    Author.new(author_name,author_email)
  end
  
  def author_name
    extract_content("//atom:feed/atom:author/atom:name")
  end
  
  def author_email
    extract_content("//atom:feed/atom:author/atom:email")
  end
  
  def generator
    extract_content("//atom:feed/atom:generator")
  end
  
  def entries
    extract("//atom:feed/atom:entry")
  end
  
  def extract(xpath)
    @doc.find(xpath, NAMESPACES)
  end
  
  def extract_content(xpath)
    extract(xpath)[0].content.strip
  end
end
