require 'shellwords'

module SimCtl
  class Command
    module Create
      COMMAND = %w[xcrun simctl create]

      # Creates a device
      #
      # @param name [String] name of the new device
      # @param devicetype [SimCtl::DeviceType] device type of the new device
      # @param runtime [SimCtl::Runtime] runtime of the new device
      # @return [SimCtl::Device] the device that was created
      def create_device(name, devicetype, runtime)
        runtime = runtime(name: runtime) unless runtime.is_a?(Runtime)
        devicetype = devicetype(name: devicetype) unless devicetype.is_a?(DeviceType)
        Executor.execute([COMMAND, Shellwords.shellescape(name), devicetype.identifier, runtime.identifier]) do |identifier|
          device(udid: identifier)
        end
      end
    end
  end
end
