module SimCtl
  class Command
    module List
      COMMAND = %w[xcrun simctl list -j]

      def list_devices
        Executor.execute([COMMAND, 'devices']) do |json|
          SimCtl::List.new json['devices'].map {|os, devices| devices.map {|device| Device.new(device.merge(os: os))}}.flatten
        end
      end

      def list_devicetypes
        Executor.execute([COMMAND, 'devicetypes']) do |json|
          SimCtl::List.new json['devicetypes'].map {|devicetype| DeviceType.new(devicetype)}
        end
      end

      def list_runtimes
        Executor.execute([COMMAND, 'runtimes']) do |json|
          SimCtl::List.new json['runtimes'].map {|runtime| Runtime.new(runtime)}
        end
      end
    end
  end
end
