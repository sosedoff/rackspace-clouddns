module CloudDns
  API_AUTH = 'https://auth.api.rackspacecloud.com'
  API_BASE = 'https://dns.api.rackspacecloud.com'
        
  module Connection
    def authenticate
      response = authentication_request
      if response.status == 204
        @auth_token         = response.headers[:x_auth_token]
        @account_id         = response.headers[:x_server_management_url].scan(/v1.0\/([\d]{1,})/).flatten.first.to_i
      end
    end
    
    # Process an asynchronous response
    # 
    def async_response(data, wait_time=1, retries=5)
      resp = AsyncResponse.new(self, data)
      retries.times do
        content = resp.content
        unless content.key?('jobId')
          return content
        end
        sleep(wait_time)
      end
    end
  end
end