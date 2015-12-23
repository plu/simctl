module SimCtl
  class Command
    module Create
      COMMAND = %w[xcrun simctl create]

      def create_device(name, device_type, runtime)
        Executor.execute([COMMAND, "'#{name}'", device_type.identifier, runtime.identifier]) do |identifier|
          device(udid: identifier)
        end
      end
    end
  end
end
