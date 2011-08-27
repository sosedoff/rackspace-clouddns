require 'spec_helper'

describe 'CloudDns::Record' do
  before :all do
    stub_authentication
    @client = CloudDns::Client.new(:username => 'foo', :api_key => 'bar')
  end
  
  it 'validates record type' do
    proc { CloudDns::Record.new(@client) }.
      should raise_error CloudDns::InvalidRecord, "Record :name required!"
      
    proc { CloudDns::Record.new(@client, :name => 'foo.bar') }.
      should raise_error CloudDns::InvalidRecord, "Record :type required!"
    
    proc { CloudDns::Record.new(@client, {:name => 'foo.bar', :type => 'FOO'}) }.
      should raise_error CloudDns::InvalidRecord, "Record :data required!"
  end
  
  it 'validates mx record' do
    proc { CloudDns::Record.new(@client, :type => 'MX', :data => 'mail.domain.com', :name => 'mail.domain.com') }.
      should raise_error CloudDns::InvalidRecord, "Record :priority required!"
  end
  
  it 'returns true if new' do
    r = CloudDns::Record.new(@client, :name => 'foo.bar', :type => 'A', :data => '127.0.0.1')
    r.new?.should == true
  end
  
  it 'returns true if not new and was changed' do
    original_data = {
      :id         => 'A-12345',
      :created_at => Time.now,
      :name       => 'foo.bar',
      :type       => 'A',
      :data       => '127.0.0.1'
    }
    
    r = CloudDns::Record.new(@client, original_data)
    r.new?.should == false
    r.changed?.should == false
    r.data = '192.168.1.1'
    r.changed?.should == true
  end
  
  it 'responds to record type methods' do
    methods = ['a?', 'aaaa?', 'mx?', 'ns?', 'txt?', 'cname?', 'srv?']
    
    r = CloudDns::Record.new(@client, :name => 'foo.bar', :type => 'A', :data => '127.0.0.1')
    methods.each do |m|
      r.respond_to?(m.to_sym).should be_true, "Does not respond to: #{m}"
    end
  end
end