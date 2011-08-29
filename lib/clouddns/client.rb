require 'clouddns/client/helpers'
require 'clouddns/client/domains'
require 'clouddns/client/records'
require 'clouddns/client/statuses'

module CloudDns
  class Client
    attr_reader :username, :api_key, :auth_token
    attr_reader :account_id
    
    include CloudDns::Request
    include CloudDns::Connection
    include CloudDns::Helpers
    include CloudDns::Domains
    include CloudDns::Records
    include CloudDns::Statuses
    
    # Initialize a new CloudDns::Client object
    # 
    # options - Set of configuration options
    #
    # options[:username] - RackspaceCloud API username
    # options[:api_key]  - RackspaceCloud API key
    #
    def initialize(options={})
      @username   = options[:username].to_s
      @api_key    = options[:api_key].to_s
      
      raise ArgumentError, "Client :username required!" if @username.empty?
      raise ArgumentError, "Client :api_key required!"  if @api_key.empty?
    end
  end
end
