require 'spec/spec_helper'

describe "AtomElement" do
  before(:each) do
    @element = AtomElement.new("name",'1234')
  end
  
  it "should have a default namespace of atom" do
    @element.namespaces.namespace.should == LibXML::XML::Namespace.new(LibXML::XML::Node.new("stuff"),'','http://www.w3.org/2005/Atom')
  end
  
  
  
end
  
