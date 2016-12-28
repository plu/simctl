require 'coveralls'
require 'simplecov'
SimpleCov.start do
  add_filter 'spec'
end
Coveralls.wear!

$LOAD_PATH.push File.expand_path("../../lib", __FILE__)
require File.dirname(__FILE__) + '/../lib/simctl.rb'

if ENV['TRAVIS']
  SimCtl.default_timeout = 300
else
  SimCtl.default_timeout = 60
end

unless ENV['CUSTOM_DEVICE_SET_PATH'] == 'false'
  SimCtl.device_set_path = Dir.mktmpdir 'foo bar'
end

RSpec.configure do |config|
  config.tty = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |c|
    c.syntax = :expect
  end

  def with_rescue(&block)
    begin
      block.class
    rescue
    end
  end
end
