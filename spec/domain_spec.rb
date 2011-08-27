require 'spec_helper'

describe 'CloudDns::Domain' do
  before :all do
    stub_authentication
    stub_get('/domains/1', {'showRecords' => 'true', 'showSubdomains' => 'true'}, 'domain.json')
    
    @client = CloudDns::Client.new(:username => 'foo', :api_key => 'bar')
  end
  
  it 'returns CloudDns::ExportRecord for export' do
    stub_get("/domains/1/export", {}, 'domain_export_async.json')
    stub_get("/status/5fa38d01-1805-4f4f-a41a-56a3859f7ea0", {}, 'domain_export.json')
    
    domain = @client.domain(1)
    resp = domain.export
    
    resp.should be_an CloudDns::ExportRecord
    resp.id.should == 1
    resp.account_id.should == 12345
    resp.content.empty?.should == false
  end
end
