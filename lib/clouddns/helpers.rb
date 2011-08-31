module CloudDns
  module Helpers
    REGEX_DOMAIN = /^[a-z\d-]+(\.[a-z\d-]+)*\.(([\d]{1,3})|([a-z]{2,3})|(aero|coop|info|museum|name))$/i
    REGEX_IPV4   = /^[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}$/
    REGEX_IPV6   = /^([a-f\d]{1,}:?)+/i
    
    # Validate a domain name
    #
    def validate_domain(value)
      value =~ REGEX_DOMAIN
    end
    
    # Validate an IP address
    #
    def validate_ip(value)
      value =~ REGEX_IPV4
    end
    
    # Validate an IPv6 address
    #
    def validate_ip6(value)
      value =~ REGEX_IPV6
    end
  end
end
