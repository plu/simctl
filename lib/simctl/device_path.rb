module SimCtl
  class DevicePath
    attr_reader :device_plist, :global_preferences_plist, :home, :preferences_plist

    def initialize(udid)
      @home = File.join(ENV['HOME'], 'Library/Developer/CoreSimulator/Devices', udid)
      @device_plist = File.join(@home, 'device.plist')
      @global_preferences_plist = File.join(@home, 'data/Library/Preferences/.GlobalPreferences.plist')
      @preferences_plist = File.join(@home, 'data/Library/Preferences/com.apple.Preferences.plist')
    end
  end
end
