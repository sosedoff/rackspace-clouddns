module CloudDns
  module Helpers
    REGEX_DOMAIN = /^[a-z\d-]+(\.[a-z\d-]+)*\.(([\d]{1,3})|([a-z]{2,3})|(aero|coop|info|museum|name))$/i
    REGEX_IP     = /^[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}$/
    REGEX_AAAA   = /^([a-f\d]{1,}:?)+/i
    
    # Validate a domain name
    #
    def validate_domain(value)
      value =~ DOMAIN_REGEX
    end
  end
end
