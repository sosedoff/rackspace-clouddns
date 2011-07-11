require 'clouddns/version'
require 'clouddns/errors'
require 'clouddns/connection'
require 'clouddns/request'
require 'clouddns/domain'
require 'clouddns/client'

module CloudDns
  class << self
    # Alias for CloudDns::Client.new
    #
    # @return CloudDns::Client
    def new(options={})
      CloudDns::Client.new(options)
    end
  end
end
