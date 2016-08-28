require 'coveralls'
Coveralls.wear!

require 'maxitest/autorun'
require 'shoulda-context'

$LOAD_PATH.push File.expand_path("../../lib", __FILE__)
require File.dirname(__FILE__) + '/../lib/simctl.rb'

if ENV['TRAVIS']
  SimCtl.default_timeout = 300
end

unless ENV['CUSTOM_DEVICE_SET_PATH'] == 'false'
  SimCtl.device_set_path = Dir.mktmpdir
end
