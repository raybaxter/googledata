require 'lib/gdata_service'
require 'net/https'

# require File.dirname(__FILE__) + '/../spec_helper'

describe Service do
  
  def observed_responses_to_bad_logins
    [
      "The login request used a username or password that is not recognized.",
      "A CAPTCHA is required. You should login to your account on the web and try this request again.",
    ]
  end
  
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
      service = Service.new("calendar.maven",'password')
      observed_responses_to_bad_logins.should include(service.client_authenticate)
     end
  end

  describe "#authentication with an invalid user" do
    
    before(:all) do
      p "This test block requires invalid authorization credentials and a live Internet connection to Google's service"
    end

    it "should respond with a known error message" do
      service = Service.new("not_a_valid_user#{Time.now.to_i}",'password')
      observed_responses_to_bad_logins.should include(service.client_authenticate)
    end
        
  end
  
  describe "#error_message_from" do
    
    before(:all) do
      @service = Service.new("user","password")
    end
        
    it "should take a simple string and return a string value" do
      @service.error_message_from("Error=BadAuthentication\n").should == "BadAuthentication"
    end
    
    it "should take a complex string and return a string value" do
      @service.error_message_from("CaptchaToken=YPpW9Tx9DNyqLxCe7AZPGfgK5B-gsKe2vF8RKPZlYpOyXnl7uMUM3OzpXwMZ42FmaSBedzU4hG9RejytwEXzlmRJfGcocLj42k8ylTiwGbyTDNPe6zsnB4EjH7uIz8mU:9Pj70SHQ6ffjXhGC9pT9uw\nCaptchaUrl=Captcha?ctoken=YPpW9Tx9DNyqLxCe7AZPGfgK5B-gsKe2vF8RKPZlYpOyXnl7uMUM3OzpXwMZ42FmaSBedzU4hG9RejytwEXzlmRJfGcocLj42k8ylTiwGbyTDNPe6zsnB4EjH7uIz8mU%3A9Pj70SHQ6ffjXhGC9pT9uw\nError=CaptchaRequired\nUrl=https://www.google.com/accounts/ErrorMsg?Email=calendar.mafasdfadssaddsaven%40gmail.com&service=cl&id=cr&timeStmp=1229575266&secTok=a6928d058068e77a6ab544f10270ccb0\n").should == "CaptchaRequired"
    end    
    
  end
    
  describe "#g_request" do
    
    before(:all) do
      @connection = Connection.stub!(:new)
      @service = Service.new("user","password")
    end

    it "should call @connection.get" do
      pending("Better stubbing")
      @connection.should_receive(:get).with("/").and_return(Net::HTTPSuccess.new)
      @service.g_request("GET","http://www.example.com/")
    end
    
  end

end

describe Connection do
  
  it "should inherit from Net::HTTPS" do
    Connection.superclass == "Net::HTTPS"
  end
  
  it "should initalize with hostname" do
    Connection.new('example.com').should_not be_nil
  end
  
  it "should set use_ssl to true" do
    Connection.new('example.com').use_ssl.should be_true
  end
  
  it "should allow setting the port" do
    Connection.new('example.com',1234).port.should == 1234
  end
  
  it "should use the default ca_file" do
    Connection.new('example.com').ca_file.should == 'config/curl-ca-bundle.crt'
  end
  
  it "should allow setting the ca_file in the environment" do
    ENV['ca_file'] = '09876'
    Connection.new('example.com').ca_file.should == '09876'
    ENV.delete('ca_file') # Otherwise breaks if tests run in reverse!
  end  
  
  it "should warn if the ca_file is not found unless it was nil" do
    pending("Checking on change of $stderr")
    ca_file = 'sakj'
    Object.should_receive(:warn, "No certificate file. Expected #{ca_file} to exist. Continuing...")
    Connection.new('example.com',123,ca_file)
  end

  it "should not warn if the ca_file is not found if location is nil" do
    pending("Checking on change of $stderr")
    pending("passes without reason")
    $stderr = StringIO.new
    lambda { Connection.new('example.com',123,nil)}.should_not change($stderr,:size)
  end
  
  it "should allow setting debug_output" do
    Connection.new('example.com').set_debug_output(true).should be_true
    Connection.new('example.com').set_debug_output($stderr).should == $stderr
  end
  
end

describe GDataException do
  
  it "should inherit from StandardError" do
    GDataException.superclass == StandardError
  end

  it "should initialize with a string" do
    GDataException.new("string").should_not be_nil
  end
  
  it "should return passed in string as #message" do
    string = "Hi Mom"
    GDataException.new(string).message.should == string
  end
    
end