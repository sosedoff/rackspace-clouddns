require 'time'
require 'hashie'

module CloudDns
  class Base
    attr_reader :client
  end
  
  class Domain < Base
    attr_reader   :id          # Domain primary ID
    attr_reader   :client_id   # Domain client ID
    attr_reader   :created_at  # Domain creation timestamp
    attr_reader   :updated_at  # Domain last update timestamp
    
    attr_accessor :name        # Domain primary name
    attr_accessor :ttl         # Domain TTL
    attr_accessor :nameservers # Collection of CloudDns::Nameserver objects
    attr_accessor :records     # Collection of CloudDns::Record objects
    
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
      @created_at = Time.parse(h.created)
      @updated_at = Time.parse(h.updated)
      @ttl        = h.ttl
      
      # Load nameservers records if present
      if h.nameservers.kind_of?(Array)
        @nameservers = h.nameservers.map { |ns| CloudDns::Nameserver.new(ns.name) }
      end
      
      # Load records list if present
      if h['recordsList']
        @records = h['recordsList'].records.map { |r| CloudDns::Record.new(client, r) }
      end
    end
    
    # Returns true if domain is a new record
    #
    def new?
      @id.nil? || @account_id.nil? || @created_at.nil?
    end
    
    # Delete domain
    #
    def delete
      @client.delete_domain(self.id)
    end
  end
end