module Atom

  NAMESPACE = %q[ atom:http://www.w3.org/2005/Atom ]
  NAMESPACES = %w[ atom:http://www.w3.org/2005/Atom ]

  class Element < LibXML::XML::Node
    
    include LibXML
    
    ELEMENT_DEFAULTS = {:type => :simple, :xpath => "//atom:feed/atom:$KEY$", :link? => false}
    
    ELEMENTS = {
      :atom_id        => { :xpath => '//atom:feed/atom:id'},
    }
    
    if false
      # Container Elements
      #   The "atom:feed" Element
      #   The "atom:entry" Element
      #   The "atom:content" Element
      #     The "type" Attribute
      #     The "src" Attribute
      #     Processing Model
      #     Examples
      # Metadata Elements
      #   The "atom:author" Element
      #   The "atom:category" Element
      #     The "term" Attribute
      #     The "scheme" Attribute
      #     The "label" Attribute
      #   The "atom:contributor" Element
      #   The "atom:generator" Element
      #   The "atom:icon" Element
      #   The "atom:id" Element
      #     Comparing atom:id
      #   The "atom:link" Element
      #     The "href" Attribute
      #     The "rel" Attribute
      #     The "type" Attribute
      #     The "hreflang" Attribute
      #     The "title" Attribute
      #     The "length" Attribute
      #   The "atom:logo" Element
      #   The "atom:published" Element
      #    The "atom:rights" Element
      #    The "atom:source" Element
      #    The "atom:subtitle" Element
      #    The "atom:summary" Element
      #    The "atom:title" Element
      #    The "atom:updated" Element

    end
    
    def initialize(name, content=nil, namespace=nil)
      super    
      namespaces.namespace = LibXML::XML::Namespace.new(self,'',Atom::NAMESPACE)
    end

    def value
      content
    end

    def define_element_accessors(elements)
      elements.each do |name, overrides|
        values = ELEMENT_DEFAULTS.merge(overrides)
        if name == :category_scheme and false
          p method_for_element(name,values)
        end
        eval(%{
          def #{name.to_s}
            #{method_for_element(name,values)}
          end
        })
      end
    end
        
    def method_for_element(name,values)
      "#{extract_method(values[:type])}(\"#{xpath_for_element(name,values[:xpath])}\")#{xpath_for_attribute(values[:attribute])}"
    end
    
    def xpath_for_element(name,xpath)
      xpath.gsub(/\$KEY\$/,name.to_s)      
    end
                        
    def xpath_for_attribute(attribute)
      attribute ? ".first.attributes[\"#{attribute}\"]" : ''
    end
    
    def extract_method(type)
      type == :compound ? 'extract' : 'extract_content'
    end
    
    def extract(xpath)
      xtract = @document.find(xpath, NAMESPACES) 
      (xtract.nil? or xtract.empty?) ? [XML::Node.new('')] : xtract
    end

    def extract_content(xpath)
      extract(xpath)[0].content.strip
    end

     

  end
  
end