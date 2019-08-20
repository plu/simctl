require 'spec_helper'

RSpec.describe SimCtl do
  it 'executes example code from readme' do
    # Select the iOS 12.4 runtime
    runtime = SimCtl.runtime(name: 'iOS 12.4')

    # Select the iPhone 6 device type
    devicetype = SimCtl.devicetype(name: 'iPhone 6')

    # Create a new device
    device = SimCtl.create_device 'Unit Tests @ iPhone 6 - 12.4', devicetype, runtime

    # Launch a new Simulator.app instance
    device.launch

    # Boot the device
    device.boot

    # Wait for the device to be booted
    device.wait { |d| d.state == :booted }

    # Kill the Simulator.app instance again
    device.shutdown
    device.kill

    # Wait until it did shutdown
    device.wait { |d| d.state == :shutdown }

    # Delete the device
    device.delete
  end
end
