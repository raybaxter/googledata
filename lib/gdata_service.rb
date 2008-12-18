require 'net/https'

class Service
  attr_reader :headers

  def initialize(user, password, service = 'cl', login_url=nil)
    @user = user
    @password = password
    @service = service
    @login_url ||='http://www.google.com:443/accounts/ClientLogin'    
  end
  
	def authenticate(login_url='http://www.google.com:443/accounts/ClientLogin')
  
    data = "accountType=HOSTED_OR_GOOGLE&Email=#{@user}&Passwd=#{@password}&service=#{@service}"
    
    response = post_data(login_url, data)
    if response.kind_of?(Net::HTTPSuccess)
    	cl_string = response.body[/Auth=(.*)/, 1]
    	@headers = { 
    		  'Content-Type' => 'application/atom+xml', 
    			'Accept' => 'application/atom+xml',
    			'Source' => '67central.com--get-feed-0.0.1',
    			'Authorization' => "GoogleLogin auth=#{cl_string}" 
    	}
    	response
    else 
      # TODO - raise
      # Error Codes  http://code.google.com/apis/accounts/docs/AuthForInstalledApps.html#Errors
      # Error Code	Description
      # BadAuthentication 	The login request used a username or password that is not recognized.
      # NotVerified 	The account email address has not been verified. The user will need to access their Google account directly to resolve the issue before logging in using a non-Google application.
      # TermsNotAgreed 	The user has not agreed to terms. The user will need to access their Google account directly to resolve the issue before logging in using a non-Google application.
      # CaptchaRequired 	A CAPTCHA is required. (A response with this error code will also contain an image URL and a CAPTCHA token.)
      # Unknown 	The error is unknown or unspecified; the request contained invalid input or was malformed.
      # AccountDeleted 	The user account has been deleted.
      # AccountDisabled 	The user account has been disabled.
      # ServiceDisabled 	The user's access to the specified service has been disabled. (The user account may still be valid.)
      # ServiceUnavailable 	The service is not available; try again later.
    	puts response
    	puts response.body
    end
  end
  
  def g_request(method="GET", uri_string=nil, data=nil, limit = 5)
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
  
  	return response if response.kind_of?(Net::HTTPSuccess)
  	return g_request(method, response['location'], data, limit-1)  if response.kind_of?(Net::HTTPRedirection)
  	return response.error!  
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
  
	def initialize(address, port = 443, ca_file = "/usr/share/curl/curl-ca-bundle.crt")
		super(address,port)
		self.use_ssl = true
    # self.set_debug_output $stderr if DEBUG
		if File.exists?(ca_file)
      # @@logger.debug "ca_file exists"
			self.ca_file = "/usr/share/curl/curl-ca-bundle.crt"
			self.verify_mode = OpenSSL::SSL::VERIFY_PEER
			self.verify_depth = 5
		else
      # @@logger.warn "No certificate file"
			self.verify_mode = OpenSSL::SSL::VERIFY_NONE
		end
	end
	
end
