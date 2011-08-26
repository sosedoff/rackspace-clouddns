require 'clouddns/client/records'

module CloudDns
  class Record
    include CloudDns::Records
    
    attr_reader :id, :created_at, :updated_at
    attr_accessor :name, :type, :data, :ttl
    
    # Initialize a new CloudDns::Record instance
    #
    # client - CloudDns::Client instance
    # data   - Domain record hash
    #
    def initialize(client, data={})
      @id         = data[:id]
      @name       = data[:name]
      @type       = data[:type]
      @ttl        = data[:ttl]
      @created_at = data[:created]
      @updated_at = data[:updated]
    end
  end
end