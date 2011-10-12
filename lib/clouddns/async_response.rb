module CloudDns
  class AsyncResponse
    attr_reader :job_id
    attr_reader :callback_url
    
    # Initialize a new CloudDns::AsyncResponse instance
    #
    # client - CloudDns::Client instance
    # data   - Response hash from asynchronous request
    #
    def initialize(client, data={})  
      @client = client
      
      unless client.kind_of?(CloudDns::Client)
        raise ArgumentError, "CloudDns::Client required!"
      end
      
      if data.kind_of?(Hash)
        @job_id       = data['jobId'].to_s
        @callback_url = data['callbackUrl'].to_s
      elsif data.kind_of?(String)
        @job_id = data.strip
      else
        raise ArgumentError, "Data required!"
      end
      
      if @job_id.empty?
        raise ArgumentError, "Job ID required!"
      end
    end
    
    # Returns a hash representation of response
    #
    def to_hash
      {:job_id => @job_id, :callback_url => @callback_url}    
    end
    
    # Get the asynchronous response content
    #
    def content
      @client.status(self.job_id)
    end
  end
end
