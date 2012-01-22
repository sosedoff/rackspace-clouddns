module CloudDns
  class Error              < StandardError; end
  
  class BadRequest         < Error; end # 400, 406
  class Unauthorized       < Error; end # 401
  class Forbidden          < Error; end # 403
  class NotFound           < Error; end # 404
  class DomainExists       < Error; end # 409
  class OverLimit          < Error; end # 413
  class DnsFault           < Error; end # 500
  class NotImplemented     < Error; end # 501
  class BadGateway         < Error; end # 502
  class ServiceUnavailable < Error; end # 503
  
  class InvalidNameserver  < Error; end
  class InvalidRecord      < Error; end
  class DublicateRecord    < Error; end
end

