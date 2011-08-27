module CloudDns
  class ExportRecord
    attr_reader :id            # Rackspace domain ID
    attr_reader :account_id    # Rackspace account ID
    attr_reader :type          # Export content type (software)
    attr_reader :content       # Raw records contents
    
    # Initialize a new CloudDns::ExportRecord instance
    #
    # data - Hash with record details
    #
    def initialize(data)
      unless data.kind_of?(Hash)
        raise ArgumentError, "Data required!"
      end
      
      @id         = data['id']
      @account_id = data['accountId']
      @type       = data['contentType']
      @content    = data['contents']
    end
  end
end