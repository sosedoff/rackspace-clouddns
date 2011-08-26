module CloudDns
  class Nameserver
    DOMAIN_REGEX = /^[a-z\d-]+(\.[a-z\d-]+)*\.(([\d]{1,3})|([a-z]{2,3})|(aero|coop|info|museum|name))$/i
    
    attr_accessor :name
    
    # Initialize a new CloudDns::Nameserver instance
    #
    # name - Nameserver name (ex.: ns.rackspace.com)
    #
    def initialize(name)
      @name = name.to_s.strip
      
      # Always required!
      if @name.empty?
        raise InvalidNameserver, "Nameserver name required!"
      end
    
      # Check if its valid  
      unless validate_ns(@name)
        raise InvalidNameserver, "Nameserver '#{name}' is invalid!"
      end
      
      @name = name
    end
    
    private
    
    # Validate nameserver name
    #
    def validate_ns(value)
      value =~ DOMAIN_REGEX
    end
  end
end