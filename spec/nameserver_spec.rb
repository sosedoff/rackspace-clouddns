require 'spec_helper'

describe 'CloudDns::Nameserver' do
  context '.new' do
    it 'returns a proper nameserver record' do
      ns = CloudDns::Nameserver.new('ns.rackspace.com')
      ns.name.should == 'ns.rackspace.com'
    end
    
    it 'raises InvalidNameserver error in empty name' do
      proc { CloudDns::Nameserver.new('') }.
        should raise_error CloudDns::InvalidNameserver, "Nameserver name required!"
    end
    
    it 'raises InvalidNameserver error on invalid name' do
      proc { CloudDns::Nameserver.new('blah') }.
        should raise_error CloudDns::InvalidNameserver, "Nameserver 'blah' is invalid!"
    end
  end
  
  it 'validates a nameserver name' do
    ns = ['foo', 'foo_bar.com', 'foo+bar.com', '...', 'http://domain.com']
    
    ns.each do |name|
      proc { CloudDns::Nameserver.new(name) }.
        should raise_error CloudDns::InvalidNameserver
    end
  end
end
