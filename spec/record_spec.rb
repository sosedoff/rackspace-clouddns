require 'spec_helper'

describe 'CloudDns::Record' do
  it 'validates record type' do
    stub_authentication
    client = CloudDns::Client.new(:username => 'foo', :api_key => 'bar')
    proc { CloudDns::Record.new(client, {:type => 'FOO'}) }.
      should raise_error CloudDns::InvalidRecord, "Invalid record type: FOO"
  end
end
