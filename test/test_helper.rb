require 'coveralls'
Coveralls.wear!

require 'maxitest/autorun'
require 'shoulda-context'

$LOAD_PATH.push File.expand_path("../../lib", __FILE__)
require File.dirname(__FILE__) + '/../lib/simctl.rb'
