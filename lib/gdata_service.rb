require 'net/https'
require 'uri'

class Service
  attr_reader :headers

  def initialize(user, password, service = 'cl', login_url=nil)
    @user = user
    @password = password
    @service = service
    @login_url ||='http://www.google.com:443/accounts/ClientLogin'    
  end
  
	def client_authenticate(login_url='http://www.google.com:443/accounts/ClientLogin')

    data = "accountType=HOSTED_OR_GOOGLE&Email=#{@user}&Passwd=#{@password}&service=#{@service}"
    
    begin
      response = post_data(login_url, data)
    rescue GDataException => e
      return humanized_message(e.message)
    end
    	
    cl_string = response.body[/Auth=(.*)/, 1]
    @headers = {  'Content-Type' => 'application/atom+xml', 
    	            'Accept' => 'application/atom+xml',
    	            'Source' => '67central.com--get-feed-0.0.1',
    	            'Authorization' => "GoogleLogin auth=#{cl_string}" }
  end


  def humanized_message(string)
    # Error Codes  http://code.google.com/apis/accounts/docs/AuthForInstalledApps.html#Errors
    case error_message_from(string)
      when "BadAuthentication"	
        "The login request used a username or password that is not recognized."
      when "NotVerified"
        "The account email address has not been verified. The user will need to access their Google account directly to resolve the issue before logging in using a non-Google application."
      when "TermsNotAgreed" 	
        "The user has not agreed to terms. The user will need to access their Google account directly to resolve the issue before logging in using a non-Google application."
      when "CaptchaRequired" 	
        "A CAPTCHA is required. You should login to your account on the web and try this request again."
      when "Unknown"
        "The error is unknown or unspecified; the request contained invalid input or was malformed."
      when "AccountDeleted"
        "The user account has been deleted."
      when "AccountDisabled"	
        "The user account has been disabled."
      when "ServiceDisabled"
        "The user's access to the specified service has been disabled. (The user account may still be valid.)"
      when "ServiceUnavailable"
        "The service is not available; try again later."
      else
        ""
      end
  end
  
  def error_message_from(string)
    # Real life examples!
    # "CaptchaToken=YPpW9Tx9DNyqLxCe7AZPGfgK5B-gsKe2vF8RKPZlYpOyXnl7uMUM3OzpXwMZ42FmaSBedzU4hG9RejytwEXzlmRJfGcocLj42k8ylTiwGbyTDNPe6zsnB4EjH7uIz8mU:9Pj70SHQ6ffjXhGC9pT9uw\nCaptchaUrl=Captcha?ctoken=YPpW9Tx9DNyqLxCe7AZPGfgK5B-gsKe2vF8RKPZlYpOyXnl7uMUM3OzpXwMZ42FmaSBedzU4hG9RejytwEXzlmRJfGcocLj42k8ylTiwGbyTDNPe6zsnB4EjH7uIz8mU%3A9Pj70SHQ6ffjXhGC9pT9uw\nError=CaptchaRequired\nUrl=https://www.google.com/accounts/ErrorMsg?Email=calendar.mafasdfadssaddsaven%40gmail.com&service=cl&id=cr&timeStmp=1229575266&secTok=a6928d058068e77a6ab544f10270ccb0\n"
    # "Error=BadAuthentication\n"
    string.split(/\n/).detect{|s| s =~ /^Error=/}.split(/=/).last    
  end
  
  def g_request(method, uri_string, data=nil, limit = 5)
  	raise "Too many redirects!" if limit <= 0 
  
  	uri = URI.parse(uri_string)
  	@http ||= Connection.new('www.google.com','443')

  	# Something like method = method.downcase.to_sym; @http.method() could work here.
  	response = case method
  						 when 'GET'
  							 @http.get(uri.request_uri, @headers)
  						 when 'PUT'
  							 @http.put(uri.request_uri, data, @headers)
  						 when 'POST'
  							 @http.post(uri.request_uri, data, @headers)
  						 when 'DELETE'
  							 @http.delete(uri.request_uri, @headers)
  						 end 
  
    # require 'ruby-debug'; debugger

    if response.kind_of?(Net::HTTPRedirection)
      return g_request(method, response['location'], data, limit-1)
    elsif response.kind_of?(Net::HTTPForbidden)
      raise GDataException.new(response.body)
    elsif response.kind_of?(Net::HTTPSuccess)
      return response
    else
  	  return response.error!
	  end
  end
  
  def get_data(uri_string, limit = 5)
  	g_request("GET", uri_string, nil, limit)
  end
    
  def delete_data(uri_string, limit = 5)
  	g_request("DELETE", uri_string, nil, limit)
  end
  
  def post_data(uri_string, data, limit = 5)
  	g_request("POST", uri_string, data, limit)
  end
  
  def put_data(uri_string, data, limit = 5)
  	g_request("PUT", uri_string, data, limit)
  end
  
end

class Connection < Net::HTTP
  
	def initialize(address, port = 443)
	  
		super(address,port)
		
		self.ca_file = ENV['ca_file'] ? ENV['ca_file'] : "config/curl-ca-bundle.crt"
		self.use_ssl = true
		if File.exists?(ca_file)
			self.verify_mode = OpenSSL::SSL::VERIFY_PEER
			self.verify_depth = 5
		else
      warn "No certificate file. Expected #{ca_file} to exist. Continuing..." unless ca_file.nil?
			self.verify_mode = OpenSSL::SSL::VERIFY_NONE
		end
	end
	
end

class GDataException < StandardError
  
  def initialize(string)
    @string = string
  end

  def message
    @string
  end
  
end