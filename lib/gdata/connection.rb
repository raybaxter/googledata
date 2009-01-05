require 'net/https'
module GData
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
  
end