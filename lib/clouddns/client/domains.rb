module CloudDns
  module Domains
    # Get a list of domain on account
    #
    # @return [Array][CloudDns::Domain]
    #
    def domains
      get("/domains")['domains'].map do |record|
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
