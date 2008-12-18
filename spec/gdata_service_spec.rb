require 'lib/gdata_service'

# require File.dirname(__FILE__) + '/../spec_helper'

describe Service do
  it "should initialize" do
    Service.new("user","password").should_not be_nil
  end
  
  describe "#authentication with valid credentials" do
    before(:all) do
      p "This test block requires valid authorization credentials and a live Internet connection to Google's service"
    end

    before(:each) do
      @service = Service.new('calendar.maven','complic*')
    end
      
    it "should authenticate" do
      @service.authenticate.should_not be_nil
    end
    
    it "should expose the headers" do
      @service.authenticate
      @service.headers.should_not be_nil
    end
    
    it "should set a valid authorization token" do
      @service.authenticate
      @service.headers['Authorization'].should match(/GoogleLogin auth=/)
      @service.headers['Authorization'].size.should == "GoogleLogin auth=DQAAAHgAAABMZexg9VNaQhrvMDRpl16GOMMh1MIiZ9QlNRibQsE7n8la0Thdzv38dffaoiKaBwkXDA9hLjftiofFAsaKz_aM5VkEUx_qEoWUy_J-gHfUg7-APU2pyvuRwt5xIYppFUlDh-kesuj7s3jv6RGXMx6vKdP20Z2VBhYG3OdTyljfng".size      
    end
    
  end

  describe "#authentication with invalid credentials" do
    before(:all) do
      p "This test block requires invalid authorization credentials and a live Internet connection to Google's service"
    end

    before(:each) do
      @service = Service.new('I_should_never_be_a_valid_user_name','password')
    end
      
    it "should not authenticate" do
      lambda {  @service.authenticate }.should raise_error
    end
        
  end
    
end

describe Connection do
  
  it "should initalize with hostname" do
    Connection.new('example.com').should_not be_nil
  end

end