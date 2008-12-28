require File.dirname(__FILE__) + '/../spec_helper'

describe Atom::Author do
  it "should be initialized with name and email address" do
    Atom::Author.new("Joe", "joe@blow.com").should_not be_nil
  end
  
  it "should have #name" do
    Atom::Author.new("Joe", "joe@blow.com").name.should == "Joe"
  end

  it "should have #email" do
    Atom::Author.new("Joe", "joe@blow.com").email.should == "joe@blow.com"
  end
  
  it "should have equality based on name and email address" do
    name = "Joe"
    email = "joe@blow.co"
    Atom::Author.new(name,email).should == Atom::Author.new(name,email)
  end
  
end