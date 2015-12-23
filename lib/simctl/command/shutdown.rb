module SimCtl
  class Command
    module Shutdown
      COMMAND = %w[xcrun simctl shutdown]

      def shutdown_device(device)
        Executor.execute([COMMAND, device.udid])
      end
    end
  end
end
