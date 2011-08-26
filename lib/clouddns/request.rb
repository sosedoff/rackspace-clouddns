require 'faraday_middleware'
require 'faraday/response/raise_clouddns_error'

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
    
    # Setup a faraday request
    #
    # url - Target URL
    #
    def connection(url)
      connection = Faraday.new(url) do |c|
        c.use(Faraday::Response::Logger)
        c.use(Faraday::Request::UrlEncoded)
        c.use(Faraday::Response::RaiseCloudDnsError)
        c.use(Faraday::Response::ParseJson)
        c.adapter(Faraday.default_adapter)
      end
    end
     
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
        'Accept'       => 'application/json',
        'X-Auth-User'  => username,
        'X-Auth-Key'   => api_key,
        'X-Auth-Token' => auth_token
      }
          
      response = connection(CloudDns::API_BASE).send(method) do |request|
        request.url("/v1.0/#{account_id}#{path}", params)
        request.headers.merge!(headers)
      end
      response.body
    end
    
    # Performs an authentication request
    def authentication_request
      headers = {
        'Accept'      => 'application/json',
        'X-Auth-User' => username || '',
        'X-Auth-Key'  => api_key  || '',
      }
      
      response = connection(CloudDns::API_AUTH).send(:get) do |request|
        request.url("/v1.0")
        request.headers.merge!(headers)
      end
    end
  end
end