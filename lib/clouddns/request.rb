require 'rest-client'
require 'yajl/json_gem'

module CloudDns
  module Request
    def get(path, options={})
      request(:get, path, options)
    end
    
    def post(path, options={})
      request(:post, path, options)
    end
    
    def put(path, options={})
      request(:put, path, options)
    end
    
    def delete(path, options={})
      request(:delete, path, options)
    end
    
    private
     
    # Perform a HTTP request
    #
    # method - Request method, one of (:get, :post, :put, :delete)
    # path   - Request path
    # params - Custom request parameters hash (default: empty)
    # raw    - Return raw response (default: false)
    #
    # @return [Hash]
    #
    def request(method, path, params={}, raw=false)
      authenticate if auth_token.nil?
      
      headers = {
        :params        => params,
        :accept        => :json,
        'X-Auth-User'  => username,
        'X-Auth-Key'   => api_key,
        'X-Auth-Token' => auth_token
      }
      resp = RestClient.send(method, "#{CloudDns::API_BASE}/#{account_id}#{path}", headers) do |resp, req, res, &block|
        handle_response_code(resp)
        JSON.parse(resp.body)
      end
    end
    
    # Performs an authentication request
    def authentication_request
      headers = {
        :accept       => :json,
        'X-Auth-User' => username,
        'X-Auth-Key'  => api_key,
      }
      
      resp = RestClient.get(CloudDns::API_AUTH, headers) do |resp, req, res, &block|
        handle_response_code(resp)
        resp
      end
    end
     
    # Process response status code
    def handle_response_code(resp) 
      case resp.code
        when 400 then raise CloudDns::BadRequest
        when 401 then raise CloudDns::Unauthorized
        when 403 then raise CloudDns::Forbidden
        when 406 then raise CloudDns::BadRequest
        when 409 then raise CloudDns::DomainExists
        when 413 then raise CloudDns::OverLimit
        when 500 then raise CloudDns::DnsFault
        when 501 then raise CloudDns::NotImplemented
        when 502 then raise CloudDns::BadGateway
        when 503 then raise CloudDns::ServiceUnavailable
      end
    end
  end
end