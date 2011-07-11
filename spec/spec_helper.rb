$:.unshift File.expand_path("../..", __FILE__)

require 'clouddns'

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end