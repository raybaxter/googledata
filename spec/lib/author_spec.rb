require 'lib/author'

describe "Author" do
  it "should be initialized with name and email address" do
    Author.new("Joe", "joe@blow.com").should_not be_nil
  end
  
  it "should have #name" do
    Author.new("Joe", "joe@blow.com").name.should == "Joe"
  end

  it "should have #email" do
    Author.new("Joe", "joe@blow.com").email.should == "joe@blow.com"
  end
  
  it "should have equality based on name and email address" do
    name = "Joe"
    email = "joe@blow.co"
    Author.new(name,email).should == Author.new(name,email)
  end
  
end