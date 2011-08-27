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
      CloudDns::AsyncResponse.new(resp)
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
      CloudDns::AsyncResponse.new(resp)
    end
    
    private
    
    def record_id(obj)
      obj.kind_of?(CloudDns::Record) ? obj.id : obj.to_s
    end
  end
end