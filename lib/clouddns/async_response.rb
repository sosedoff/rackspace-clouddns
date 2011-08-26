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
    
    # Check the job status
    #
    # NOTE: Does not work. Does not return anything
    #
    def status
      @status ||= @client.status(self.job_id) rescue ''  
    end
  end
end
