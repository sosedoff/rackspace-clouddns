require 'bundler'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = 'spec/*_spec.rb'
  t.verbose = false
end

task :default => :test

task :install do
  require './lib/clouddns/version'
  
  puts "> Uninstalling gem..."
  puts `gem uninstall rackspace-clouddns --version=#{CloudDns::VERSION}`
  
  puts "> Building gem..."
  puts `gem build rackspace-clouddns.gemspec`
  
  puts "> Installing gem..."
  puts `gem install rackspace-clouddns-#{CloudDns::VERSION}.gem`
end