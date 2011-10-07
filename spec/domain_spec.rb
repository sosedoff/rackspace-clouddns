require 'spec_helper'

describe 'CloudDns::Domain' do
  before :all do
    stub_authentication
    stub_get('/domains/1', {'showDetails' => 'true', 'showRecords' => 'true', 'showSubdomains' => 'true'}, 'domain.json')
    
    @client = CloudDns::Client.new(:username => 'foo', :api_key => 'bar')
  end
  
  it 'returns CloudDns::ExportRecord for export' do
    stub_get("/domains/1/export", {'showDetails' => 'true'}, 'domain_export_async.json')
    stub_get("/status/5fa38d01-1805-4f4f-a41a-56a3859f7ea0", {'showDetails' => 'true'}, 'domain_export.json')
    
    domain = @client.domain(1)
    resp = domain.export
    
    resp.should be_an CloudDns::ExportRecord
    resp.id.should == 1
    resp.account_id.should == 12345
    resp.content.empty?.should == false
  end
  
  it 'creates domain records via shortcuts' do
    domain = @client.new_domain('foobar.com', :email => 'foo@bar.com')
    
    domain.a('foobar.com', :data => '127.0.0.1').a?.should be_true
    domain.cname('dev.foobar.com', :data => 'www.foobar.com').cname?.should be_true
    domain.mx('foobar.com', :priority => 10, :data => '127.0.0.1').mx?.should be_true
    domain.ns('foobar.com', :data => 'ns.rackspace.com').ns?.should be_true
  
    domain.a(:name => 'foo.com', :data => '127.0.0.1').a?.should be_true
    domain.cname(:name => 'www.foo.com', :data => 'foo.com').cname?.should be_true
    domain.ns(:name => 'ns.rackspace.com', :data => 'ns.rackspace.com').ns?.should be_true
    domain.mx(:name => 'mail.foo.com', :data => 'mail.google.com', :priority => 10).mx?.should be_true
    
  end
end
