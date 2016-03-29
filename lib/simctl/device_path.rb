require 'simctl/object'

module SimCtl
  class DevicePath
    attr_reader :home, :device_plist

    def initialize(udid)
      @home = File.join(ENV['HOME'], 'Library/Developer/CoreSimulator/Devices', udid)
      @device_plist = File.join(@home, 'device.plist')
    end
  end
end
