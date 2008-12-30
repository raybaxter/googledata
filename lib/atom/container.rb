require 'rubygems'
require 'libxml'

module Atom
  class Container
    include LibXML

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
    
    NAMESPACES =  %w[ atom:http://www.w3.org/2005/Atom ]  

    ELEMENT_DEFAULTS = {:type => :simple, :xpath => "//atom:feed/atom:$KEY$", :link? => false}

    ELEMENTS = {
      :atom_id        => { :xpath => '//atom:feed/atom:id'},
      :title          => {},
      :subtitle       => {},
      :updated        => {},
      :generator      => {},
      :author         => {},
      :links          => {:type => :compound, :xpath => "//atom:feed/atom:link"},
      :entries        => {:type => :compound, :xpath => "//atom:feed/atom:entry"},
      
      :author_name    => {:xpath => '//atom:feed/atom:author/atom:name'},
      :author_email   => {:xpath => '//atom:feed/atom:author/atom:email'},
      
      :alternate_link => {:type => :compound, :xpath => '//atom:feed/atom:link[@rel=\"alternate\"]', :attribute => "href"}, 
      :feed_link      => {:type => :compound, :xpath => '//atom:feed/atom:link[@rel=\"http://schemas.google.com/g/2005#feed\"]', :attribute => "href"},
      :post_link      => {:type => :compound, :xpath => '//atom:feed/atom:link[@rel=\"http://schemas.google.com/g/2005#post\"]', :attribute => "href"},
      :self_link      => {:type => :compound, :xpath => '//atom:feed/atom:link[@rel=\"self\"]', :attribute => "href"},
        
    }
    
    attr_reader :document

    def self.file(file_name)
      self.new(XML::Parser.file(file_name).parse)
    end

    def initialize(document)
      @document = document
      define_element_accessors(ELEMENTS)
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
      xpath.gsub(/\$KEY\$/,name.to_s)      
    end
                        
    def xpath_for_attribute(attribute)
      attribute ? ".first.attributes[\"#{attribute}\"]" : ''
    end
    
    def extract_method(type)
      type == :compound ? 'extract' : 'extract_content'
    end
    
    def value
      content
    end

    def value=(string)
      content = string
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