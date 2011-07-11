module CloudDns
  module Domains
    # Get all domains associated with the account
    def domains
      get("/domains")['domains'].map do |record|
        d = CloudDns::Domain.new(record)
        d.client = self
        d
      end
    end
    
    # Get a single domain details
    def domain(id)
      d = CloudDns::Domain.new(get("/domains/#{id}"))
      d.client = self
      d
    end
  end
end
