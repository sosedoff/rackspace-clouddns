module CloudDns
  module Domains
    # Get a list of domain on account
    #
    # options - Options hash
    # options[:limit] - Specify a limit of domains to fetch (default: 10)
    # options[:offset] - Specify an offset to start from (default: 0)
    #
    # @return [Array][CloudDns::Domain]
    #
    def domains(options={:limit => 10, :offset => 0})
      get("/domains", options)['domains'].map do |record|
        CloudDns::Domain.new(self, record)
      end
    end
    
    # Get a single domain details
    #
    # id - Domain ID
    #
    # @return [CloudDns::Domain]
    #
    def domain(id)
      CloudDns::Domain.new(self, get("/domains/#{id}"))
    end
  end
end
