module Atom

  NAMESPACES = %w[ atom:http://www.w3.org/2005/Atom ]

  class Element < LibXML::XML::Node
    
    include LibXML
    
    ELEMENT_DEFAULTS = { :type => :simple, :xpath => "//atom:$CONTAINER$/atom:$KEY$" }
    
    ELEMENTS = {
      :atom_id          => { :xpath => '//atom:$CONTAINER$/atom:id' },
      :title            => { },
      :subtitle         => { },
      :content          => { },
      :updated          => { },
      :published        => { :xpath => '//atom:$CONTAINER$/atom:published' },

      :generator        => { },
      :generator_uri    => { :type => :compound, :xpath => '//atom:feed/atom:generator', :attribute => "uri" },
      :generator_version=> { :type => :compound, :xpath => '//atom:feed/atom:generator', :attribute => "version" },    

      :author           => { },
      :author_name      => { :xpath => '//atom:$CONTAINER$/atom:author/atom:name' },
      :author_email     => { :xpath => '//atom:$CONTAINER$/atom:author/atom:email' },

      :links            => { :type => :compound, :xpath => "//atom:$CONTAINER$/atom:link" },
      :entries          => { :type => :compound, :xpath => "//atom:$CONTAINER$/atom:entry" },
                        
      :category         => { },
      :category_term    => { :type => :compound, :xpath => '//atom:$CONTAINER$/atom:category', :attribute => "term" },
      :category_scheme  => { :type => :compound, :xpath => '//atom:$CONTAINER$/atom:category', :attribute => "scheme" },
      :category_label   => { :type => :compound, :xpath => '//atom:$CONTAINER$/atom:category', :attribute => "label" },      
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
    
    def self.file(file_name)
      self.new(XML::Parser.file(file_name).parse)
    end
    
    def initialize(document)
      @document = document
      define_element_accessors(elements_for_accessors)
    end
    
    def elements_for_accessors
      ELEMENTS
    end
    
    def container_for_accessors
      'feed'
    end
    
    def define_element_accessors(elements)
      elements.each do |name, overrides|
        values = ELEMENT_DEFAULTS.merge(overrides)
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
      xpath.gsub(/\$CONTAINER\$/,container_for_accessors).gsub(/\$KEY\$/,name.to_s)      
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

     def method_missing(name)
       # Only used to produce nicer debugging error messages
       raise UnknownAttribute.new(name)
     end

  end
  
end

class UnknownAttribute < StandardError
  attr_reader :message
  def initialize(name)
    @message = "Method: #{name} - does not exist in scope"
  end
  
end