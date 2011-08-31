module CloudDns
  module Helpers
    DOMAIN_REGEX = /^[a-z\d-]+(\.[a-z\d-]+)*\.(([\d]{1,3})|([a-z]{2,3})|(aero|coop|info|museum|name))$/i
    
    # Validate a domain name
    #
    def validate_domain(value)
      value =~ DOMAIN_REGEX
    end
  end
end
