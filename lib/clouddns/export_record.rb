module CloudDns
  class ExportRecord
    attr_reader :id            # Rackspace domain ID
    attr_reader :account_id    # Rackspace account ID
    attr_reader :type          # Export content type (software)
    attr_reader :content       # Raw records contents
    
    def initialize(response)
      unless response.kind_of?(CloudDns::AsyncResponse)
        raise ArgumentError, "CloudDns::AsyncResponse required!"
      end
      
      data = response.content
      
      @id         = data['id']
      @account_id = data['accountId']
      @type       = data['contentType']
      @content    = data['contents']
    end
  end
end