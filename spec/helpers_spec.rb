require 'spec_helper'

describe 'CloudDns::Helpers' do
  include CloudDns::Helpers
  
  it 'validates domain' do
    validate_domain('foo.com').should_not be_nil
    validate_domain('sub.foo.com').should_not be_nil
    validate_domain('foo-123.com').should_not be_nil
    validate_domain('foo').should be_nil
    validate_domain('....').should be_nil
    validate_domain('foo_bar.com').should be_nil
    validate_domain('foo.hello').should be_nil
  end
  
  it 'validates an IP address' do
    validate_ip('127.0.0.1').should_not be_nil
    validate_ip('10.10.10.10').should_not be_nil
    validate_ip('192.168.0').should be_nil
    validate_ip('blah').should be_nil
  end
end
