require File.dirname(__FILE__) + '/../../spec_helper'

describe GData::Service do
  
  def observed_responses_to_bad_logins
    [
      "The login request used a username or password that is not recognized.",
      "A CAPTCHA is required. You should login to your account on the web and try this request again.",
    ]
  end
  
  it "should initialize" do
    GData::Service.new("user","password").should_not be_nil
  end
  
  describe "#authentication with valid credentials" do
    
    before(:all) do
      p "This test block requires valid authorization credentials and a live Internet connection to Google's service"
    end

    before(:each) do
      @service = GData::Service.new('calendar.maven','complic*')
    end
      
    it "should client_authenticate" do
      @service.client_authenticate.should_not be_nil
    end
    
    it "should expose the headers" do
      @service.client_authenticate
      @service.headers.should_not be_nil
    end
    
    it "should set a valid authorization token" do
      @service.client_authenticate
      @service.headers['Authorization'].should match(/GoogleLogin auth=/)
      @service.headers['Authorization'].size.should == "GoogleLogin auth=DQAAAHgAAABMZexg9VNaQhrvMDRpl16GOMMh1MIiZ9QlNRibQsE7n8la0Thdzv38dffaoiKaBwkXDA9hLjftiofFAsaKz_aM5VkEUx_qEoWUy_J-gHfUg7-APU2pyvuRwt5xIYppFUlDh-kesuj7s3jv6RGXMx6vKdP20Z2VBhYG3OdTyljfng".size      
    end
    
  end

  describe "#authentication with valid user and invalid password" do
    
    it "should not client_authenticate" do
      service = GData::Service.new("calendar.maven",'password')
      observed_responses_to_bad_logins.should include(service.client_authenticate)
     end
  end

  describe "#authentication with an invalid user" do
    
    before(:all) do
      p "This test block requires invalid authorization credentials and a live Internet connection to Google's service"
    end

    it "should respond with a known error message" do
      service = GData::Service.new("not_a_valid_user#{Time.now.to_i}",'password')
      observed_responses_to_bad_logins.should include(service.client_authenticate)
    end
        
  end
  
  describe "#error_message_from" do
    
    before(:all) do
      @service = GData::Service.new("user","password")
    end
        
    it "should take a simple string and return a string value" do
      @service.error_message_from("Error=BadAuthentication\n").should == "BadAuthentication"
    end
    
    it "should take a complex string and return a string value" do
      @service.error_message_from("CaptchaToken=YPpW9Tx9DNyqLxCe7AZPGfgK5B-gsKe2vF8RKPZlYpOyXnl7uMUM3OzpXwMZ42FmaSBedzU4hG9RejytwEXzlmRJfGcocLj42k8ylTiwGbyTDNPe6zsnB4EjH7uIz8mU:9Pj70SHQ6ffjXhGC9pT9uw\nCaptchaUrl=Captcha?ctoken=YPpW9Tx9DNyqLxCe7AZPGfgK5B-gsKe2vF8RKPZlYpOyXnl7uMUM3OzpXwMZ42FmaSBedzU4hG9RejytwEXzlmRJfGcocLj42k8ylTiwGbyTDNPe6zsnB4EjH7uIz8mU%3A9Pj70SHQ6ffjXhGC9pT9uw\nError=CaptchaRequired\nUrl=https://www.google.com/accounts/ErrorMsg?Email=calendar.mafasdfadssaddsaven%40gmail.com&service=cl&id=cr&timeStmp=1229575266&secTok=a6928d058068e77a6ab544f10270ccb0\n").should == "CaptchaRequired"
    end    
    
  end
    
  describe "#request" do
    
    before(:all) do
      @connection = GData::Connection.stub!(:new)
      @service = GData::Service.new("user","password")
    end

    it "should call @connection.get" do
      pending("Better stubbing")
      @connection.should_receive(:get).with("/").and_return(Net::HTTPSuccess.new)
      @service.request("GET","http://www.example.com/")
    end
    
  end

end

