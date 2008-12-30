require 'spec/spec_helper'

describe Atom::Metadata do
  it "should works" do
    Atom::Metadata.new().should_not be_nil
  end
  
  
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