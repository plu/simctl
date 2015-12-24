module SimCtl
  class Command
    module Create
      COMMAND = %w[xcrun simctl create]

      # Creates a device
      #
      # @param name [String] name of the new device
      # @param device_type [SimCtl::DeviceTYpe] device type of the new device
      # @param runtime [SimCtl::Runtime] runtime of the new device
      def create_device(name, device_type, runtime)
        Executor.execute([COMMAND, "'#{name}'", device_type.identifier, runtime.identifier]) do |identifier|
          device(udid: identifier)
        end
      end
    end
  end
end
