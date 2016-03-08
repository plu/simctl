require 'shellwords'

module SimCtl
  class Command
    module Create
      COMMAND = %w[xcrun simctl create]

      # Creates a device
      #
      # @param name [String] name of the new device
      # @param device_type [SimCtl::DeviceType] device type of the new device
      # @param runtime [SimCtl::Runtime] runtime of the new device
      # @return [SimCtl::Device] the device that was created
      def create_device(name, device_type, runtime)
        Executor.execute([COMMAND, Shellwords.shellescape(name), device_type.identifier, runtime.identifier]) do |identifier|
          device(udid: identifier)
        end
      end
    end
  end
end
