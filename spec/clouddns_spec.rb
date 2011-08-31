require 'spec_helper'

describe 'CloudDns' do
  it 'creates an instance of CloudDns::Client via .new' do
    CloudDns.respond_to?(:new).should == true
    CloudDns.new(:username => 'foo', :api_key => 'bar').should be_a CloudDns::Client
  end
end
