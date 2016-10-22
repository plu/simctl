require 'cfpropertylist'
require 'ostruct'
require 'simctl/device_path'
require 'simctl/device_settings'
require 'simctl/object'
require 'timeout'

module SimCtl
  class Device < Object
    attr_reader :availability, :name, :os, :state, :udid

    # Boots the device
    #
    # @return [void]
    def boot!
      SimCtl.boot_device(self)
    end

    # Deletes the device
    #
    # @return [void]
    def delete!
      SimCtl.delete_device(self)
    end

    # Returns the device type
    #
    # @return [SimCtl::DeviceType]
    def devicetype
      @devicetype ||= SimCtl.devicetype(identifier: plist.deviceType)
    end

    # <b>DEPRECATED:</b> Please use <tt>device.settings.disable_keyboard_helpers!</tt> instead.
    # Disables the keyboard helpers
    #
    # @return [void]
    def disable_keyboard_helpers!
      settings.disable_keyboard_helpers!
    end

    # Erases the device
    #
    # @return [void]
    def erase!
      SimCtl.erase_device(self)
    end

    # Installs an app on a device
    #
    # @param path Absolute path to the app that should be installed
    # @return [void]
    def install!(path)
      SimCtl.install_app(self, path)
    end

    # Uninstall an app from a device
    #
    # @param app_id App identifier of the app that should be uninstalled
    # @return [void]
    def uninstall!(app_id)
      SimCtl.uninstall_app(self, app_id)
    end

    # Kills the device
    #
    # @return [void]
    def kill!
      SimCtl.kill_device(self)
    end

    # Launches the Simulator
    #
    # @return [void]
    def launch!(scale=1.0, opts={})
      SimCtl.launch_device(self, scale, opts)
    end

    # Launches an app in the given device
    #
    # @param opts [Hash] options hash - `{ wait_for_debugger: true/false }`
    # @param identifier [String] the app identifier
    # @param args [Array] optional launch arguments
    # @return [void]
    def launch_app!(identifier, args=[], opts={})
      SimCtl.launch_app(self, identifier, args, opts)
    end

    # Opens the url on the device
    #
    # @param url [String] The url to be opened on the device
    # @return [void]
    def open_url!(url)
      SimCtl.open_url(self, url)
    end

    def path
      @path ||= DevicePath.new(udid)
    end

    # Reloads the device information
    #
    # @return [void]
    def reload!
      device = SimCtl.device(udid: udid)
      device.instance_variables.each do |ivar|
        instance_variable_set(ivar, device.instance_variable_get(ivar))
      end
    end

    # Renames the device
    #
    # @return [void]
    def rename!(name)
      SimCtl.rename_device(self, name)
    end

    # Resets the device
    #
    # @return [void]
    def reset!
      SimCtl.reset_device name, devicetype, runtime
    end

    # Resets the runtime
    #
    # @return [SimCtl::Runtime]
    def runtime
      @runtime ||= SimCtl.runtime(identifier: plist.runtime)
    end

    # Returns the settings object
    #
    # @ return [SimCtl::DeviceSettings]
    def settings
      @settings ||= DeviceSettings.new(path)
    end

    # Shuts down the runtime
    #
    # @return [void]
    def shutdown!
      SimCtl.shutdown_device(self)
    end

    # Returns the state of the device
    #
    # @return [sym]
    def state
      @state.downcase.to_sym
    end

    # Reloads the device until the given block returns true
    #
    # @return [void]
    def wait!(timeout=SimCtl.default_timeout)
      Timeout::timeout(timeout) do
        loop do
          break if yield SimCtl.device(udid: udid)
        end
      end
      reload!
    end

    def ==(other)
      return false if other.nil?
      return false unless other.kind_of? Device
      other.udid == udid
    end

    private

    def plist
      @plist ||= OpenStruct.new(CFPropertyList.native_types(CFPropertyList::List.new(file: path.device_plist).value))
    end

  end
end
