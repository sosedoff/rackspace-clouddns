module CloudDns
  class AsyncResponse
    attr_reader :job_id         # An identifier for the specific request.
    attr_reader :callback_url   # Resource locator for querying the status of the request.
    attr_reader :status         # An indicator of the request status: RUNNING, COMPLETED, or ERROR.
    attr_reader :request_url    # The url of the original request.
    attr_reader :verb           # The type of the original request: PUT, POST, or DELETE.
    attr_reader :request        # The original request data, if any.
    attr_reader :response       # The results of a COMPLETE operation, if any.
    attr_reader :error          # The results of an ERROR operation.
    
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
      
      @request_url = data['requestUrl']
      @verb        = data['verb']
      @status      = data['status']
      @request     = data['request']
      @error       = data['error']
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
    
    # Returns true if job is running
    #
    def running?
      self.status == 'RUNNING'
    end
  
    # Returns true if job execution is completed
    #
    def completed?
      self.status == 'COMPLETED'
    end
    
    # Returns true if job execution failed
    def error?
      self.status == 'ERROR'
    end
  end
end
