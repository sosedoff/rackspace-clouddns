module CloudDns
  API_AUTH = 'https://auth.api.rackspacecloud.com'
  API_BASE = 'https://dns.api.rackspacecloud.com'
        
  module Connection
    ASYNC_WAIT_TIME    = 1     # Number of seconds before (and between) async requests.
    ASYNC_WAIT_RETRIES = 10    # How many times are we doing it before giving up.
    
    # Primary authentication request
    # if failed, raises CloudDns::Unauthorized exception
    #
    def authenticate
      response = authentication_request
      if response.status == 204
        @auth_token         = response.headers[:x_auth_token]
        @account_id         = response.headers[:x_server_management_url].scan(/v1.0\/([\d]{1,})/).flatten.first.to_i
      end
    end
    
    # Wait for async response result
    #
    # data      - Data that comes from async response operation (put, post, delete)
    # wait_time - Number of seconds before (and between) async requests (default: 1)
    # retries   - How many times are we doing it before giving up (default: 10)
    # 
    def async_response(data, wait_time=ASYNC_WAIT_TIME, retries=ASYNC_WAIT_RETRIES)
      raise ArgumentError, "Wait time should be > 0" if wait_time <= 0    
      raise ArgumentError, "Retries number should be positive" if retries < 0
      
      resp = AsyncResponse.new(self, data)
      
      retries.times do
        sleep(wait_time)
        content = resp.content
        return content unless content.key?('jobId')
      end
    end
  end
end