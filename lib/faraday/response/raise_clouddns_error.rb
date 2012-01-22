require 'faraday_middleware'
require 'clouddns/error_helper'

module Faraday
  class Response::RaiseCloudDnsError < Response::Middleware
    include CloudDns::ErrorHelper
  end
end