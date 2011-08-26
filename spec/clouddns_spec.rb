require 'spec_helper'

describe CloudDns do
  context '.new' do
    it 'creates an instance of CloudDns::Client' do
      CloudDns.respond_to?(:new).should == true
      CloudDns.new.should be_a CloudDns::Client
    end
  end
  
  context '.nameserver' do
    it 'creates an instance of CloudDns::Nameserver' do
      CloudDns.respond_to?(:nameserver).should == true
      CloudDns.respond_to?(:ns).should == true
      CloudDns.nameserver('ns.rackspace.com').should be_a CloudDns::Nameserver
    end
  end
end
