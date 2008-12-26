require 'rubygems'
require 'libxml'
class Element < LibXML::XML::Node
  def initialize(name, content=nil, namespace=nil)
    super
  end
  
  def value
    content
  end
  
  def value=(string)
    content= string
  end
  
end