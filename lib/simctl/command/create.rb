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
        Executor.execute([COMMAND, "'#{name}'", device_type.identifier, runtime.identifier]) do |identifier|
          device(udid: identifier)
        end
      end

      # Shutdown, delete and create a device
      #
      # @param name [String] name of the new device
      # @param device_type [SimCtl::DeviceType] device type of the new device
      # @param runtime [SimCtl::Runtime] runtime of the new device
      # @return [SimCtl::Device] the device that was created
      # @yield [exception] an exception that might happen during shutdown/delete of the old device
      def reset_device(name, device_type, runtime)
        begin
          SimCtl.list_devices.where(name: name, os: runtime.name).each do |device|
            device.shutdown! if device.state != 'Shutdown'
            device.delete!
          end
        rescue Exception => exception
          yield exception if block_given?
        end
        create_device name, device_type, runtime
      end
    end
  end
end
