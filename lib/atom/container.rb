
module Atom
  class Container < Element

    # Container Elements
    #   The "atom:feed" Element
    #   The "atom:entry" Element
    #   The "atom:content" Element
    #     The "type" Attribute
    #     The "src" Attribute

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
    
    ELEMENTS = Atom::Element::ELEMENTS.merge({
      :alternate_link   => {:type => :compound, :xpath => '//atom:$CONTAINER$/atom:link[@rel=\"alternate\"]', :attribute => "href"}, 
      :feed_link        => {:type => :compound, :xpath => '//atom:$CONTAINER$/atom:link[@rel=\"http://schemas.google.com/g/2005#feed\"]', :attribute => "href"},
      :post_link        => {:type => :compound, :xpath => '//atom:$CONTAINER$/atom:link[@rel=\"http://schemas.google.com/g/2005#post\"]', :attribute => "href"},
      :self_link        => {:type => :compound, :xpath => '//atom:$CONTAINER$/atom:link[@rel=\"self\"]', :attribute => "href"},
    })
    
    attr_reader :document

    def elements_for_accessors
      ELEMENTS
    end
  end
  
end