module CloudDns
  module Domains
    # Initialize (not create) a new domain
    #
    # name - Domain name
    #
    # @return [CloudDns::Domain]
    #
    def new_domain(name, options={})
      options.merge!(:name => name)
      CloudDns::Domain.new(self, options)
    end
    
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
    def get_domains(options={:limit => 10, :offset => 0})
      get("/domains", options)['domains'].map do |record|
        CloudDns::Domain.new(self, record)
      end
    end
    
    alias :domains :get_domains
    
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
    def get_domain(id, options={:records => true, :subdomains => true})
      params = {}
      params['showRecords']    = true if options[:records] == true
      params['showSubdomains'] = true if options[:subdomains] == true
      
      CloudDns::Domain.new(self, get("/domains/#{id}", params))
    end
    
    alias :domain :get_domain
    
    # Create a new domain under the account
    #
    # domain - CloudDns::Domain instance
    #
    # @return [CloudDns::Domain]
    #
    def create_domain(name, email)
      data = {'name' => name, 'emailAddress' => email}
      resp = post("/domains", {:domains => [data]})
      data = async_response(resp)['domains'].first
      CloudDns::Domain.new(self, data)
    end
    
    # Update an existing domain information
    #
    # domain - CloudDns::Domain instance
    #
    def update_domain(domain)    
      changed_records = domain.records.select { |r| r.changed? }.map(&:to_hash)
      new_records = domain.records.select { |r| r.new? }.map(&:to_hash)
      
      # Update existing records first
      unless changed_records.empty?
        async_response(put("/domains/#{domain.id}/records", {:records => changed_records}))
      end
      
      # Create new records
      unless new_records.empty?
         async_response(post("/domains/#{domain.id}/records", {:records => new_records}))
      end
    end
    
    # Delete an existing domain. Returns an AsyncResponse instance
    #
    # domain - CloudDns::Domain instance or domain ID
    #
    # @return [Hash]
    #
    def delete_domain(domain)
      options = {'deleteSubdomains' => true}
      async_response(delete("/domains/#{domain_id(domain)}", options))    
    end
    
    # Export domain contents
    #
    # domain - CloudDns::Domain instance or domain ID
    #
    # @return [CloudDns::ExportRecord]
    #
    def export_domain(domain)
      resp = get("/domains/#{domain_id(domain)}/export")
      data = async_response(resp)
      ExportRecord.new(data)
    end
  end
end
