require 'simctl/object'

module SimCtl
  class Device < Object
    attr_reader :availability, :name, :os, :state, :udid
  end
end
