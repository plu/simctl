module SimCtl
  class Command
    module List
      COMMAND = %w[xcrun simctl list -j]

      # Find a device
      #
      # @param filter [Hash] the filter
      # @return [SimCtl::Device, nil] the device matching the given filter
      def device(filter)
        list_devices.where(filter).first
      end

      # Find a device type
      #
      # @param filter [Hash] the filter
      # @return [SimCtl::DeviceType, nil] the device type matching the given filter
      def devicetype(filter)
        list_devicetypes.where(filter).first
      end

      # List all devices
      #
      # @return [SimCtl::List] a list of SimCtl::Device objects
      def list_devices
        Executor.execute([COMMAND, 'devices']) do |json|
          SimCtl::List.new(json['devices'].map {|os, devices| devices.map {|device| Device.new(device.merge(os: os))}}.flatten)
        end
      end

      # List all device types
      #
      # @return [SimCtl::List] a list of SimCtl::DeviceType objects
      def list_devicetypes
        Executor.execute([COMMAND, 'devicetypes']) do |json|
          SimCtl::List.new(json['devicetypes'].map {|devicetype| DeviceType.new(devicetype)})
        end
      end

      # List all runtimes
      #
      # @return [SimCtl::List] a list of SimCtl::Runtime objects
      def list_runtimes
        Executor.execute([COMMAND, 'runtimes']) do |json|
          SimCtl::List.new(json['runtimes'].map {|runtime| Runtime.new(runtime)})
        end
      end

      # Find a runtime
      #
      # @param filter [Hash] the filter
      # @return [SimCtl::Runtime, nil] the runtime matching the given filter
      def runtime(filter)
        list_runtimes.where(filter).first
      end

    end
  end
end
