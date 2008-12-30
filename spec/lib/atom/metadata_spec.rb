require 'spec/spec_helper'

require 'spec/lib/atom/common_elements'

describe Atom::Metadata do
  it "should work" do
    Atom::Metadata.new().should_not be_nil
  end
  
 it_should_behave_like "common Atom elements"
  
  
  # Metadata Elements
  #   The "atom:category" Element
  #     The "term" Attribute
  #     The "scheme" Attribute
  #     The "label" Attribute
  #   The "atom:generator" Element
  #   The "atom:icon" Element
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
  #    The "atom:summary" Element
  
end