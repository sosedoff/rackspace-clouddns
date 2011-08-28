require 'time'
require 'hashie'
require 'digest/sha1'

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
    attr_accessor :email       # Domain email address
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
      @account_id = h.account_id || h.accountId
      @name       = h.name.to_s.strip
      @email      = (h.emailAddress || h.email).to_s.strip
      @created_at = h.created.nil? ? nil : Time.parse(h.created)
      @updated_at = h.updated.nil? ? nil : Time.parse(h.updated)
      @ttl        = h.ttl || CloudDns::Record::DEFAULT_TTL
      
      if @name.empty?
        raise ArgumentError, "Domain :name required!"
      end
      
      if @email.empty? && new?
        raise ArgumentError, "Domain :emailAddress or :email required!"
      end
      
      # Load nameservers records if present
      if h.nameservers.kind_of?(Array)
        @nameservers = h.nameservers.map { |ns| CloudDns::Nameserver.new(ns.name) }
      end
      
      # Load records list if present
      @records = []
      if h['recordsList']
        h['recordsList'].records.map { |r| @records << CloudDns::Record.new(client, r) }
      end
      
      @original_checksum = checksum
    end
    
    # Returns true if domain is a new record
    #
    def new?
      @id.nil? && @account_id.nil?
    end
    
    # Returns true if domain was changed
    #
    def changed?
      new? ? false : @original_checksum != checksum
    end
    
    # Save domain information
    #
    def save
      new? ? @client.create_domain(self) : @client.update_domain(self)
    end
    
    # Delete domain
    #
    def delete
      new? ? false : @client.delete_domain(self)
    end
    
    def export
      @client.export_domain(self)
    end
    
    # Add a new domain record
    #
    # options - Domain record options
    #
    # options[:name] - Record name
    # options[:type] - Record type (A, CNAME, MX, NS, TXT, etc)
    # options[:data] - Record content (ip address, etc.)
    # options[:ttl]  - Record TTL (default: 3600)
    #
    # @return [CloudDns::Record]
    #
    def add_record(options={})
      @records << CloudDns::Record.new(@client, options)
    end
    
    # Get all records by type
    #
    # type - Record type (A, AAAA, CNAME, MX, ...)
    #
    # return [Array][CloudDns::Record]
    #
    def find_records(type)
      unless Record::TYPES.include?(type)
        raise ArgumentError, "Invalid record type: #{type}"
      end
      @records.select { |r| r.type == type }
    end
    
    #
    # Shorthands to add new specific records
    #
    
    def a    (options={}) ; add_record(options.merge(:type => 'A'))     ; end
    def aaaa (options={}) ; add_record(options.merge(:type => 'AAAA'))  ; end
    def cname(options={}) ; add_record(options.merge(:type => 'CNAME')) ; end
    def ns   (options={}) ; add_record(options.merge(:type => 'NS'))    ; end
    def mx   (options={}) ; add_record(options.merge(:type => 'MX'))    ; end
    def txt  (options={}) ; add_record(options.merge(:type => 'TXT'))   ; end
    def srv  (options={}) ; add_record(options.merge(:type => 'SRV'))   ; end
    
    #
    # Shorthands to get records by type
    #
  
    def a_records     ; find_records('A')     ; end
    def aaaa_records  ; find_records('AAAA')  ; end
    def cname_records ; find_records('CNAME') ; end
    def ns_records    ; find_records('NS')    ; end
    def mx_records    ; find_records('MX')    ; end
    def txt_records   ; find_records('TXT')   ; end
    def srv_records   ; find_records('SRC')   ; end
    
    private
    
    def checksum
      Digest::SHA1.hexdigest([@name, @email, @ttl].join)
    end
  end
end