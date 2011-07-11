require 'clouddns/client/domains'

module CloudDns
  class Client
    attr_reader :username, :api_key, :auth_token
    attr_reader :account_id
    
    include CloudDns::Request
    include CloudDns::Connection
    include CloudDns::Domains
    
    # Initialize a new CloudDns::Client object
    # 
    # options - Set of configuration options:
    #   :username   - RackspaceCloud API username
    #   :api_key    - RackspaceCloud API key
    #
    def initialize(options={})
      @username   = options[:username]
      @api_key    = options[:api_key]
    end
  end
end
