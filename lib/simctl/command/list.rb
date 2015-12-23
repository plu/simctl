module SimCtl
  class Command
    module List
      COMMAND = %w[xcrun simctl list -j]

      def device(hash)
        list_devices.where(hash).first
      end

      def devicetype(hash)
        list_devicetypes.where(hash).first
      end

      def list_devices
        Executor.execute([COMMAND, 'devices']) do |json|
          SimCtl::List.new(json['devices'].map {|os, devices| devices.map {|device| Device.new(device.merge(os: os))}}.flatten)
        end
      end

      def list_devicetypes
        Executor.execute([COMMAND, 'devicetypes']) do |json|
          SimCtl::List.new(json['devicetypes'].map {|devicetype| DeviceType.new(devicetype)})
        end
      end

      def list_runtimes
        Executor.execute([COMMAND, 'runtimes']) do |json|
          SimCtl::List.new(json['runtimes'].map {|runtime| Runtime.new(runtime)})
        end
      end

      def runtime(hash)
        list_runtimes.where(hash).first
      end

    end
  end
end
