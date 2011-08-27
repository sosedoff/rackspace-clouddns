require 'spec_helper'

describe 'CloudDns' do
  it 'creates an instance of CloudDns::Client via .new' do
    CloudDns.respond_to?(:new).should == true
    CloudDns.new.should be_a CloudDns::Client
  end

  it 'creates an instance of CloudDns::Nameserver via .nameserver' do
    CloudDns.respond_to?(:nameserver).should == true
    CloudDns.respond_to?(:ns).should == true
    CloudDns.nameserver('ns.rackspace.com').should be_a CloudDns::Nameserver
  end
end
