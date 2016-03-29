require 'simctl/object'

module SimCtl
  class DevicePath
    attr_reader :device_plist, :home, :preferences_plist

    def initialize(udid)
      @home = File.join(ENV['HOME'], 'Library/Developer/CoreSimulator/Devices', udid)
      @device_plist = File.join(@home, 'device.plist')
      @preferences_plist = File.join(@home, 'data/Library/Preferences/com.apple.Preferences.plist')
    end

    def edit(path, &block)
      plist = File.exists?(path) ? CFPropertyList::List.new(file: path) : CFPropertyList::List.new
      content = CFPropertyList.native_types(plist.value) || {}
      plist.value = CFPropertyList.guess(yield content)
      plist.save(path, CFPropertyList::List::FORMAT_BINARY)
    end

  end
end
