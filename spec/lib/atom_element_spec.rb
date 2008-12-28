require 'spec/spec_helper'

describe "Atom::Element" do
  before(:each) do
    @element = Atom::Element.new("name",'1234')
  end
  
  it "should be initialized with an XML::Node" do
    @element.should_not be_nil
  end
  
  it "should have a #value that returns the content of the node" do
    @element.value.should == '1234'
  end  
  
  it "should have a default namespace of atom" do
    @element.namespaces.namespace.should == LibXML::XML::Namespace.new(LibXML::XML::Node.new("stuff"),'','http://www.w3.org/2005/Atom')
  end
  
end
  
