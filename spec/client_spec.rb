require 'spec_helper'

describe CloudDns::Client do
  context 'on authentication' do 
    it 'raises CloudDns::Unauthorized exception' do
      stub_request(:get, auth_url).
         with(:headers => {'Accept'=>'application/json', 'X-Auth-Key'=>'', 'X-Auth-User'=>''}).
         to_return(:status => 401, :body => "", :headers => {})
      
      proc { CloudDns.new.authenticate }.should raise_error CloudDns::Unauthorized
    end
    
    it 'raises CloudDns::Unauthorized exception for invalid credentials' do
      stub_request(:get, auth_url).
         with(:headers => {'Accept'=>'application/json', 'X-Auth-Key'=>'key', 'X-Auth-User'=>'invalid'}).
         to_return(:status => 401, :body => "", :headers => {})
      
      proc {
        CloudDns.new(:username => 'invalid', :api_key => 'key').authenticate
      }.should raise_error CloudDns::Unauthorized
    end
    
    it 'sets authentication token for valid credentials' do
      stub_authentication
      client = CloudDns.new(:username => 'foo', :api_key => 'bar')
      client.auth_token.nil?.should == true
      client.authenticate
      client.auth_token.nil?.should == false
      client.auth_token.should == 'AUTH_TOKEN'
      client.account_id.should == 12345
    end
  end
  
  context 'with authentication' do
    before :each do
      @client = CloudDns::Client.new(:username => 'foo', :api_key => 'bar')
      stub_authentication
    end
    
    it 'returns a list of domains' do
      stub_get('/domains', {:limit => '10', :offset => '0'}, 'domains.json')
      domains = @client.domains    
      domains.should be_an Array
      domains.size.should == 2
      
      d = domains.first
      d.should be_an CloudDns::Domain
      d.id.should == 1
      d.name.should == 'foobar.com'
      d.client.should == @client
    end
  
    it 'returns a single domain' do
      stub_get('/domains/1', {'showRecords' => 'true', 'showSubdomains' => 'true'}, 'domain.json')
      domain = @client.domain(1)
      domain.should be_an CloudDns::Domain
      domain.id.should == 1
      domain.name.should == 'foobar.com'
      domain.client.should == @client
      domain.nameservers.size.should == 2
    end
    
    it 'raises CloudDns::NotFound if requested domain does not exist' do
      stub_failure(:get, '/domains/2', {}, 404)
      proc { @client.domain(2, {}) }.should raise_error CloudDns::NotFound
    end
  end
end
