#!/usr/bin/env rake
require 'rake/testtask'

def test_pattern
  'test/tc_*.rb'
end

desc "Run tests"
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = test_pattern
  t.warning = true
end

desc "Run tests with SimpleCov coverage"
task :coverage do
  $LOAD_PATH << './lib'
  require 'simplecov'
  SimpleCov.start do
    add_filter '/test/'
  end
  require 'test/unit'
  Dir.glob(test_pattern).each do |file|
    require_relative file
  end
end

task :default => [:test]
