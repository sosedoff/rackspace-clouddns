module CloudDns
  module Domains
    # Get a list of domain on account
    #
    # options - Options hash. Available options are:
    #
    # options[:name]   - Filter by domain name
    # options[:limit]  - Specify a limit of domains to fetch (default: 10)
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
    # id      - Domain ID
    # options - Fetch options
    #
    # options[:records]    - Fetch all records (default: true)
    # options[:subdomains] - Fetch all subdomains (default: true)
    #
    # @return [CloudDns::Domain]
    #
    def domain(id, options={:records => true, :subdomains => true})
      params = {}
      params['showRecords']    = true if options[:records] == true
      params['showSubdomains'] = true if options[:subdomains] == true
      
      CloudDns::Domain.new(self, get("/domains/#{id}", params))
    end
    
    # Create a new domain under the account
    #
    # domain - CloudDns::Domain instance
    #
    # @return [CloudDns::Domain]
    #
    def create_domain(domain)
      # TODO
    end
    
    # Update an existing domain information
    #
    # domain - CloudDns::Domain instance
    #
    def update_domain(domain)
      # TODO
    end
    
    # Delete an existing domain. Returns an AsyncResponse instance
    #
    # domain - CloudDns::Domain instance
    #
    # @return [CloudDns::AsyncResponse]
    #
    def delete_domain(domain)
      options = {'deleteSubdomains' => true}
      AsyncResponse.new(self, delete("/domains/#{domain.id}", options))
    end
  end
end
