
module Atom
  class Container < Element

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
    
    ELEMENTS = {
      :atom_id          => { :xpath => '//atom:feed/atom:id'},
      :title            => {},
      :subtitle         => {},
      :updated          => {},
      :generator        => {},
      :author           => {},
      :links            => {:type => :compound, :xpath => "//atom:feed/atom:link"},
      :entries          => {:type => :compound, :xpath => "//atom:feed/atom:entry"},
                        
      :author_name      => {:xpath => '//atom:feed/atom:author/atom:name'},
      :author_email     => {:xpath => '//atom:feed/atom:author/atom:email'},
                        
      :category         => {},
      :category_scheme  => {:type => :compound, :xpath => '//atom:feed/atom:category', :attribute => "scheme"},
      :category_term    => {:type => :compound, :xpath => '//atom:feed/atom:category', :attribute => "term"},
                        
      :alternate_link   => {:type => :compound, :xpath => '//atom:feed/atom:link[@rel=\"alternate\"]', :attribute => "href"}, 
      :feed_link        => {:type => :compound, :xpath => '//atom:feed/atom:link[@rel=\"http://schemas.google.com/g/2005#feed\"]', :attribute => "href"},
      :post_link        => {:type => :compound, :xpath => '//atom:feed/atom:link[@rel=\"http://schemas.google.com/g/2005#post\"]', :attribute => "href"},
      :self_link        => {:type => :compound, :xpath => '//atom:feed/atom:link[@rel=\"self\"]', :attribute => "href"},
        
    }
    
    attr_reader :document

    def self.file(file_name)
      self.new(XML::Parser.file(file_name).parse)
    end
    
    def initialize(document)
      elements = ELEMENTS.merge(local_elements)
      @document = document
      define_element_accessors(elements)
    end
    
    def local_elements
      {}
    end
        
  end
  
end