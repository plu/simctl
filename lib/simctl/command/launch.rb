module SimCtl
  class Command
    module Launch
      XCODE_HOME = `xcode-select -p`.chomp

      # Launches a Simulator instance with the given device
      #
      # @param device [SimCtl::Device] the device to launch
      # @return [void]
      def launch_device(device)
        # Launching the same device twice does not work.
        # Simulator.app would just hang. Solution: Kill first.
        kill_device(device)
        command = "open -n #{XCODE_HOME}/Applications/Simulator.app --args -ConnectHardwareKeyboard 0 -CurrentDeviceUDID #{device.udid}"
        system command
      end
    end
  end
end
