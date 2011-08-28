module CloudDns
  module Records
    # Get an existing domain record
    #
    # domain - CloudDns::Domain instance or domain ID
    # record - CloudDns::Record instance or record ID
    #
    # @return [CloudDns::Record]
    #
    def get_record(domain, record)
      resp = get("/domains/#{domain_id(domain)}/records/#{record_id(record)}")
      CloudDns::Record.new(self, resp)
    end
    
    alias :record :get_record
    
    # Get all existing domain records
    #
    # domain - CloudDns::Domain instance or domain ID
    #
    # @return [Array][CloudDns::Record]
    #
    def get_records(domain)
      resp = get("/domains/#{domain_id(domain)}/records")
      resp['records'].map { |r| CloudDns::Record.new(self, r) }
    end
    
    alias :records :get_records
    
    # Add a new domain record
    #
    # domain - CloudDns::Domain instance or domain ID
    # record - CloudDns::Record instance or Hash instance
    #
    # @return [CloudDns::AsyncResponse]
    #
    def create_record(domain, record)
      if record.kind_of?(Hash)
        record = CloudDns::Record.new(self, record)
      elsif !record.kind_of?(CloudDns::Record)
        raise ArgumentError, "CloudDns::Record required!"
      end
      
      data = {'records' => [record.to_hash]}
      resp = post("/domains/#{domain_id(domain)}/records", data)
      async_response(resp)
    end
    
    # Update an existing domain record
    #
    # domain - CloudDns::Domain instance or domain ID
    # record - CloudDns::Record instance
    #
    # @return [CloudDns::AsyncResponse]
    #
    def update_record(domain, record)
      resp = put("/domains/#{domain_id(domain)}/records/#{record.id}", record.to_hash)
      async_response(resp)
    end
    
    # Delete an existing domain record
    #
    # domain - CloudDns::Domain instance or domain ID
    # record - CloudDns::Record instance or record ID
    #
    # @return [CloudDns::AsyncRecord]
    #
    def delete_record(domain, record)
      resp = delete("/domains/#{domain_id(domain)}/records/#{record_id(record)}")
      async_response(resp)
    end
    
    # Delete multiple domain records
    #
    # domain - CloudDns::Domain instance or domain ID
    #
    def delete_records(domain, records)
      ids = records.map { |r| {:id => record_id(r)} }
      resp = delete("/domains/#{domain_id(domain)}/records", ids)
      async_response(resp)
    end
  end
end