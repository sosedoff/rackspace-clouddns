require 'bundler'
require 'rspec/core/rake_task'
require 'resque/tasks'

RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = 'spec/*_spec.rb'
  t.verbose = false
end

task :default => :test