require 'time'
require 'hashie'

module CloudDns
  class Base
    attr_reader :client
  end
  
  class Domain < Base
    attr_reader :id, :account_id
    attr_accessor :name, :ttl
    attr_accessor :nameservers
    
    # Initialize a new CloudDns::Domain instance
    #
    # client - CloudDns::Client instance (required)
    # data   - Domain data hash
    #
    def initialize(client, data={})
      h = Hashie::Mash.new(data)
      
      unless client.kind_of?(CloudDns::Client)
        raise ArgumentError, "CloudDns::Client required!"
      end
      
      @client     = client
      @id         = h.id
      @account_id = h.account_id
      @name       = h.name
      @created_at = h.created
      @updated_at = h.updated
      @ttl        = h.ttl
      
      # Load nameservers records if present
      if h.nameservers
        @nameservers = h.nameservers.map { |ns| CloudDns::Nameserver.new(ns.name) }
      end
      
      # Load records list if present
      if h['recordsList']
        @records = h['recordsList'].records.map { |r| CloudDns::Record.new(client, r) }
      end
    end
  end
end