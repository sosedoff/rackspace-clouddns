module CloudDns
  module Domains
    # Get a list of domain on account
    #
    # options - Options hash. Available options are:
    # options[:name] - Filter by domain name
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
      options = {
        'showRecords' => true,
        'showSubdomains' => true
      }
      
      CloudDns::Domain.new(self, get("/domains/#{id}", options))
    end
    
    # Create a new domain under the account
    #
    # name - New domain name
    #
    # @return [CloudDns::Domain]
    #
    def create_domain(name, email, record)
      # TODO
    end
    
    # Delete an existing domain. Returns an AsyncResponse instance
    #
    # id - Domain ID
    #
    # @return [CloudDns::AsyncResponse]
    #
    def delete_domain(id)
      options = {'deleteSubdomains' => true}
      AsyncResponse.new(self, delete("/domains/#{id}", options))
    end
  end
end
