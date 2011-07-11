require 'hashie'

module CloudDns
  class Domain < Hashie::Trash
    property :id
    property :account_id,   :from => 'accountId'
    property :email,        :from => 'emailAddress'
    property :name
    property :nameservers
    property :record_list,  :from => 'recordsList'
    property :created
    property :updated
    property :ttl
    
    attr_reader :client
    
    # Returns a list of all records
    def records
      record_list.records
    end
        
    # Assign a client connection to the record
    def client= (c)
      raise ArgumentError, "CloudDns::Client required!" unless c.kind_of?(CloudDns::Client)
      @client = c
    end
  end
  
  class Subdomain < Hashie::Trash ; end
end