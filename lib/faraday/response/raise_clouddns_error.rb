require 'faraday_middleware'

module Faraday
  class Response::RaiseCloudDnsError < Response::Middleware
    def on_complete(response)
      case response[:status].to_i
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