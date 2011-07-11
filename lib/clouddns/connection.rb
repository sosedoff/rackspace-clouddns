module CloudDns
  API_AUTH = 'https://auth.api.rackspacecloud.com/v1.0'
  API_BASE = 'https://dns.api.rackspacecloud.com/v1.0'
        
  module Connection
    def authenticate
      resp = authentication_request
      if resp.code == 204
        @auth_token         = resp.headers[:x_auth_token]
        @account_id         = resp.headers[:x_server_management_url].scan(/v1.0\/([\d]{1,})/).flatten.first
      end
    end
  end
end