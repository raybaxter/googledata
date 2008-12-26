require 'rubygems'
require 'libxml'
class AtomElement < Element
  def initialize(name, content=nil, namespace=nil)
    super    
    namespaces.namespace = LibXML::XML::Namespace.new(self,'','http://www.w3.org/2005/Atom')
  end
    
  def atom_id
    extract_content("//atom:feed/atom:id")
  end

  def value
    content
  end
  
  def value=(string)
    content= string
  end
  
end