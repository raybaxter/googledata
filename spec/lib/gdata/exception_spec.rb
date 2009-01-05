require File.dirname(__FILE__) + '/../../spec_helper'

describe GData::Exception do
  
  it "should inherit from StandardError" do
    GData::Exception.superclass == StandardError
  end

  it "should initialize with a string" do
    GData::Exception.new("string").should_not be_nil
  end
  
  it "should return passed in string as #message" do
    string = "Hi Mom"
    GData::Exception.new(string).message.should == string
  end
    
end