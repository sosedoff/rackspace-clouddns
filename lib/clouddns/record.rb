require 'clouddns/client/records'

module CloudDns
  class Record < Base
    include CloudDns::Records
    
    TYPES = %w(A AAAA CNAME MX NS TXT SRV)
    DEFAULT_TTL = 3600
    
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
      @name       = data.name.to_s.strip
      @type       = data.type.to_s.strip
      @data       = data.data.to_s.strip
      @ttl        = data.ttl || DEFAULT_TTL
      @created_at = data.created
      @updated_at = data.updated
        
      # Require client!
      unless client.kind_of?(CloudDns::Client)
        raise ArgumentError, "CloudDns::Client required!"
      end
      
      raise InvalidRecord, "Record :name required!" if @name.empty?
      raise InvalidRecord, "Record :type required!" if @type.empty?
      raise InvalidRecord, "Record :data required!" if @data.empty?
      
      if !TYPES.include?(@type)
        raise InvalidRecord, "Invalid record type: #{@type}. Allowed types: #{TYPES.join(', ')}."
      end
    end
    
    # Returns true if record does not exists
    #
    def new?
      @id.nil? && @created_at.nil?
    end
    
    def to_hash
      h = {'name' => @name, 'data' => @data, 'type' => @type, 'ttl' => @ttl}
      h.merge!(:id => @id) unless new?
      h
    end
  end
end