#!/usr/bin/env rake
require 'rake/testtask'

dir = File.dirname(__FILE__)

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = Dir.glob("#{dir}/test/*_test.rb").sort
  t.warning = true
end

desc "Run gem tests by default"
task :default => :test
