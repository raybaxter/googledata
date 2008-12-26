require 'rubygems'
require 'libxml'

class AtomFeed 
  include LibXML
  NAMESPACES =  %w[ atom:http://www.w3.org/2005/Atom ]

  attr_reader :document
  
  def self.file(file_name)
    self.new(XML::Parser.file(file_name).parse)
  end
  
  def initialize(document)
    @document = document
  end
  
  def atom_id
    extract_content("//atom:feed/atom:id")
  end

  def value
    content
  end
  
  def value=(string)
    content = string
  end
  
  def title
   extract_content("//atom:feed/atom:title")
  end
  
  def subtitle
    extract_content("//atom:feed/atom:subtitle")
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
    @author ||= Author.new(author_name,author_email)
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
    xtract = @document.find(xpath, NAMESPACES) 
    (xtract.nil? or xtract.empty?) ? [XML::Node.new('')] : xtract
  end
  
  def extract_content(xpath)
    extract(xpath)[0].content.strip
  end
  
end