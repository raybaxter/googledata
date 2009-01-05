require File.dirname(__FILE__) + '/../../spec_helper'

describe GData::Connection do
  
  it "should inherit from Net::HTTPS" do
    GData::Connection.superclass == "Net::HTTPS"
  end
  
  it "should initalize with hostname" do
    GData::Connection.new('example.com').should_not be_nil
  end
  
  it "should set use_ssl to true" do
    GData::Connection.new('example.com').use_ssl.should be_true
  end
  
  it "should allow setting the port" do
    GData::Connection.new('example.com',1234).port.should == 1234
  end
  
  it "should use the default ca_file" do
    GData::Connection.new('example.com').ca_file.should == 'config/curl-ca-bundle.crt'
  end
  
  it "should allow setting the ca_file in the environment" do
    ENV['ca_file'] = '09876'
    GData::Connection.new('example.com').ca_file.should == '09876'
    ENV.delete('ca_file') # Otherwise breaks if tests run in reverse!
  end  
  
  it "should warn if the ca_file is not found unless it was nil" do
    pending("Checking on change of $stderr")
    ca_file = 'sakj'
    Object.should_receive(:warn, "No certificate file. Expected #{ca_file} to exist. Continuing...")
    GData::Connection.new('example.com',123,ca_file)
  end

  it "should not warn if the ca_file is not found if location is nil" do
    pending("Checking on change of $stderr")
    pending("passes without reason")
    $stderr = StringIO.new
    lambda { Connection.new('example.com',123,nil)}.should_not change($stderr,:size)
  end
  
  it "should allow setting debug_output" do
    GData::Connection.new('example.com').set_debug_output(true).should be_true
    GData::Connection.new('example.com').set_debug_output($stderr).should == $stderr
  end
  
end

