require 'clouddns/version'
require 'clouddns/configuration'
require 'clouddns/errors'
require 'clouddns/template'
require 'clouddns/connection'
require 'clouddns/request'
require 'clouddns/async_response'
require 'clouddns/domain'
require 'clouddns/nameserver'
require 'clouddns/record'
require 'clouddns/export_record'
require 'clouddns/client'

module CloudDns
  extend CloudDns::Configuration
  
  class << self
    # Shorthand to CloudDns::Client.new
    #
    # @return [CloudDns::Client]
    #
    def new(options={})
      CloudDns::Client.new(options)
    end
    
    # Shorthand to CloudDns::Nameserver.new
    #
    # name - Nameserver name (ex.: 'rs.rackspace.com')
    #
    # @return [CloudDns::Nameserver]
    #
    def nameserver(name)
      CloudDns::Nameserver.new(name)
    end
    
    alias :ns :nameserver
  end
end
