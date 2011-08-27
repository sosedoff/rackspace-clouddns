module CloudDns
  class AsyncResponse
    attr_reader :job_id
    attr_reader :callback_url
    
    # Initialize a new CloudDns::AsyncResponse instance
    #
    # client - CloudDns::Client instance
    # data   - Response data from regular request
    #
    def initialize(client, data={})  
      @client       = client
      @job_id       = data['jobId'].to_s
      @callback_url = data['callbackUrl'].to_s
      
      unless client.kind_of?(CloudDns::Client)
        raise ArgumentError, "CloudDns::Client required!"
      end
      
      if @job_id.empty?
        raise ArgumentError, "Job ID required!"
      end
    end
    
    # Get the asynchronous response content
    #
    def content
      @content ||= @client.status(self.job_id)
    end
  end
end
