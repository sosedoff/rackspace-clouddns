require 'spec_helper'

describe 'CloudDns::Record' do
  it 'validates record type' do
    stub_authentication
    
    client = CloudDns::Client.new(:username => 'foo', :api_key => 'bar')
    
    proc { CloudDns::Record.new(client) }.
      should raise_error CloudDns::InvalidRecord, "Record :name required!"
      
    proc { CloudDns::Record.new(client, :name => 'foo.bar') }.
      should raise_error CloudDns::InvalidRecord, "Record :type required!"
    
    proc { CloudDns::Record.new(client, {:name => 'foo.bar', :type => 'FOO'}) }.
      should raise_error CloudDns::InvalidRecord
  end
end
