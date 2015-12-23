#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rake/testtask'

desc 'Execute simctl tests'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Default: Execute simctl tests'
task default: :test
