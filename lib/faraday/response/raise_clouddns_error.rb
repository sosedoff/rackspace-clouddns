require 'faraday_middleware'

module CloudDns
  module ErrorHelper
    
    def raise_error code, message = ""
      case code
        when 400 then raise CloudDns::BadRequest.new message
        when 401 then raise CloudDns::Unauthorized.new message
        when 403 then raise CloudDns::Forbidden.new message
        when 404 then raise CloudDns::NotFound.new message
        when 406 then raise CloudDns::BadRequest.new message
        when 409 then raise CloudDns::DomainExists.new message
        when 413 then raise CloudDns::OverLimit.new message
        when 500 then raise CloudDns::DnsFault.new message
        when 501 then raise CloudDns::NotImplemented.new message
        when 502 then raise CloudDns::BadGateway.new message
        when 503 then raise CloudDns::ServiceUnavailable.new message
      end
    end
    
    def on_complete(response)
      raise_error(response[:status].to_i)
    end
  end
end

module Faraday
  class Response::RaiseCloudDnsError < Response::Middleware
    include CloudDns::ErrorHelper
  end
end