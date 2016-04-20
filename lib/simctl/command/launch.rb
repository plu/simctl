require 'shellwords'

module SimCtl
  class Command
    module Launch
      LAUNCH_APP_COMMAND = 'xcrun simctl launch'
      SUPPORTED_SCALE = [1.0, 0.75, 0.5, 0.25]
      XCODE_HOME = `xcode-select -p`.chomp

      # Launches a Simulator instance with the given device
      #
      # @param device [SimCtl::Device] the device to launch
      # @return [void]
      def launch_device(device, scale=1.0, opts={})
        raise "unsupported scale '#{scale}' (supported: #{SUPPORTED_SCALE.join(', ')})" unless SUPPORTED_SCALE.include?(scale)
        # Launching the same device twice does not work.
        # Simulator.app would just hang. Solution: Kill first.
        kill_device(device)
        args = {
          '-ConnectHardwareKeyboard' => 1,
          '-CurrentDeviceUDID' => device.udid,
          "-SimulatorWindowLastScale-#{device.devicetype.identifier}" => scale,
        }.merge(opts).zip.flatten.join(' ')
        command = "open -Fgn #{XCODE_HOME}/Applications/Simulator.app --args #{args}"
        system command
      end

      # Launches an app in the given device
      #
      # @param device [SimCtl::Device] the device to launch
      # @param opts [Hash] options hash - `{ wait_for_debugger: true/false }`
      # @param identifier [String] the app identifier
      # @param args [Array] optional launch arguments
      # @return [void]
      def launch_app(device, identifier, args=[], opts={})
        launch_args = args.map {|arg| Shellwords.shellescape arg}
        launch_opts = opts[:wait_for_debugger] ? '-w' : ''
        Executor.execute([LAUNCH_APP_COMMAND, launch_opts, device.udid, identifier, launch_args])
      end
    end
  end
end
