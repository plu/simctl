module SimCtl
  class DevicePath
    def initialize(device)
      @device = device
    end

    def device_plist
      @device_plist ||= File.join(home, 'device.plist')
    end

    def global_preferences_plist
      @global_preferences_plist ||= File.join(home, 'data/Library/Preferences/.GlobalPreferences.plist')
    end

    def home
      @home ||= File.join(device_set_path, device.udid)
    end

    def launchctl
      @launchctl ||= if Xcode::Version.gte? '9.0'
                       "#{Xcode::Path.home}//Platforms/iPhoneOS.platform/Developer/Library/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/bin/launchctl"
                     else
                        File.join(runtime_root, 'bin/launchctl')
                     end
    end

    def preferences_plist
      @preferences_plist ||= File.join(home, 'data/Library/Preferences/com.apple.Preferences.plist')
    end

    private

    attr_reader :device

    def device_set_path
      return SimCtl.device_set_path unless SimCtl.device_set_path.nil?
      File.join(ENV['HOME'], 'Library/Developer/CoreSimulator/Devices')
    end

    def locate_runtime_root
      "/Library/Developer/CoreSimulator/Profiles/Runtimes/#{device.runtime.name}.simruntime/Contents/Resources/RuntimeRoot".tap do |path|
        return path if File.exists?(path)
      end
      Xcode::Path.sdk_root
    end

    def runtime_root
      @runtime_root ||= locate_runtime_root
    end
  end
end
