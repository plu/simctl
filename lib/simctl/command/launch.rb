module SimCtl
  class Command
    module Launch
      XCODE_HOME = `xcode-select -p`.chomp
      SUPPORTED_SCALE = [1.0, 0.75, 0.5, 0.25]

      # Launches a Simulator instance with the given device
      #
      # @param device [SimCtl::Device] the device to launch
      # @return [void]
      def launch_device(device, scale=1.0)
        raise "unsupported scale '#{scale}' (supported: #{SUPPORTED_SCALE.join(', ')})" unless SUPPORTED_SCALE.include?(scale)
        # Launching the same device twice does not work.
        # Simulator.app would just hang. Solution: Kill first.
        kill_device(device)
        command = "open -Fgn #{XCODE_HOME}/Applications/Simulator.app --args -ConnectHardwareKeyboard 0 -CurrentDeviceUDID #{device.udid} -SimulatorWindowLastScale-#{device.devicetype.identifier} #{scale}"
        system command
      end
    end
  end
end
