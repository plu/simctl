module SimCtl
  class DevicePath
    attr_reader :device_plist, :global_preferences_plist, :home, :preferences_plist

    def initialize(udid)
      @home = File.join(device_set_path, udid)
      @device_plist = File.join(@home, 'device.plist')
      @global_preferences_plist = File.join(@home, 'data/Library/Preferences/.GlobalPreferences.plist')
      @preferences_plist = File.join(@home, 'data/Library/Preferences/com.apple.Preferences.plist')
    end

    private

    def device_set_path
      return SimCtl.device_set_path unless SimCtl.device_set_path.nil?
      File.join(ENV['HOME'], 'Library/Developer/CoreSimulator/Devices')
    end
  end
end
