require 'spec_helper'

describe CloudDns do
  describe '.new' do
    it 'creates an instance of CloudDns::Client directly' do
      CloudDns.respond_to?(:new).should == true
      CloudDns.new.should be_a CloudDns::Client
    end
  end
end
