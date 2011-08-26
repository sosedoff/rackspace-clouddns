require 'clouddns/client/records'

module CloudDns
  class Record < Base
    include CloudDns::Records
    
    TYPES = %(A AAAA CNAME MX NS TXT SRV)
    
    attr_reader :id, :created_at, :updated_at
    attr_accessor :name, :type, :data, :ttl
    
    # Initialize a new CloudDns::Record instance
    #
    # client - CloudDns::Client instance
    # data   - Domain record hash
    #
    def initialize(client, data={})
      data = Hashie::Mash.new(data)
      
      @client     = client
      @id         = data.id
      @name       = data.name
      @type       = data.type
      @ttl        = data.ttl
      @created_at = data.created
      @updated_at = data.updated
      
      # Require client!
      unless client.kind_of?(CloudDns::Client)
        raise ArgumentError, "CloudDns::Client required!"
      end
      
      # Check if we've got a valid type
      unless TYPES.include?(@type)
        raise InvalidRecord, "Invalid record type: #{@type}"
      end
    end
  end
end