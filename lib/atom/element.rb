require 'rubygems'
require 'libxml'

module Atom
  class Element < LibXML::XML::Node
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
  
end