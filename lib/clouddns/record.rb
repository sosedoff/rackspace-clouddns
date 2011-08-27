require 'digest/sha1'
require 'clouddns/client/records'

module CloudDns
  class Record < Base
    include CloudDns::Records
    
    TYPES = %w(A AAAA CNAME MX NS TXT SRV)
    DEFAULT_TTL = 3600
    
    attr_reader :id, :created_at, :updated_at
    attr_accessor :name, :type, :data, :ttl, :priority
    
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
      @priority   = data.priority
      @created_at = data.created
      @updated_at = data.updated
        
      # Require client!
      unless client.kind_of?(CloudDns::Client)
        raise ArgumentError, "CloudDns::Client required!"
      end
      
      raise InvalidRecord, "Record :name required!" if @name.empty?
      raise InvalidRecord, "Record :type required!" if @type.empty?
      raise InvalidRecord, "Record :data required!" if @data.empty?
      
      if mx? && @priority.nil?
        raise InvalidRecord, "Record :priority required!"  
      end
      
      if !TYPES.include?(@type)
        raise InvalidRecord, "Invalid record type: #{@type}. Allowed types: #{TYPES.join(', ')}."
      end
      
      # Calculate checksum to track changes
      @original_checksum = checksum
    end
    
    def a?     ; @type == 'A'     ; end
    def aaaa?  ; @type == 'AAAA'  ; end
    def cname? ; @type == 'CNAME' ; end
    def txt?   ; @type == 'TXT'   ; end
    def ns?    ; @type == 'NS'    ; end
    def mx?    ; @type == 'MX'    ; end
    def src?   ; @type == 'SRV'   ; end
    
    # Returns true if record does not exists
    #
    def new?
      @id.nil? && @created_at.nil?
    end
    
    # Returns true if record was changed
    #
    def changed?
      checksum != @original_checksum
    end
    
    # Returns a hash containing the record data for API usage
    # 
    def to_hash
      h = {'name' => @name, 'data' => @data, 'type' => @type, 'ttl' => @ttl}
      h.merge!(:id => @id) unless new?
      h.merge!(:priority => @priority) if mx?
      h
    end
    
    def to_json(options={})
      MultiJson.encode(to_hash)
    end
    
    def to_s
      chunks = [@name, @ttl, 'IN', @type]
      chunks << @priority if mx?
      chunks << @data
      chunks.join(' ')
    end
    
    private
    
    def checksum
      Digest::SHA1.hexdigest(to_s)
    end
  end
end