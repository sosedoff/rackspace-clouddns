module CloudDns
  module Helpers
    # Automatically detect domain ID
    #
    def domain_id(obj)
      obj.kind_of?(CloudDns::Domain) ? obj.id : obj.to_s
    end
    
    # Automatically detect record ID
    #
    def record_id(obj)
      obj.kind_of?(CloudDns::Record) ? obj.id : obj.to_s
    end
  end
end
