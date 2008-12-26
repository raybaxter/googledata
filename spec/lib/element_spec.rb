require 'lib/element'

describe "Element" do
  before(:each) do
    @element = Element.new("name",'1234')
  end
  
  it "should be initialized with an XML::Node" do
    @element.should_not be_nil
  end
  
  it "should have a #value that returns the content of the node" do
    @element.value.should == '1234'
  end  
  
end
  
