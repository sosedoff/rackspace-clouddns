require 'clouddns/client/helpers'
require 'clouddns/client/domains'
require 'clouddns/client/records'
require 'clouddns/client/statuses'

module CloudDns
  class Client
    attr_reader :username
    attr_reader :api_key
    attr_reader :auth_token
    attr_reader :account_id
    
    attr_reader :api_auth
    attr_reader :api_base
    
    include CloudDns::Request
    include CloudDns::Connection
    include CloudDns::ErrorHelper
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
    # options[:location] - RackspaceCloud account location, (default to :us)
    #
    def initialize(options={})
      
      options[:location] ||= :us
      
      @username   = options[:username].to_s
      @api_key    = options[:api_key].to_s
      @api_auth   = CloudDns::API_AUTH[options[:location]]
      @api_base   = CloudDns::API_BASE[options[:location]]
      @auth_token = options[:auth_token]
      @account_id = options[:account_id]
      
      raise ArgumentError, "Client :username required!" if @username.empty?
      raise ArgumentError, "Client :api_key required!"  if @api_key.empty?
    end
  end
end
