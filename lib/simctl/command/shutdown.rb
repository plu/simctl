module SimCtl
  class Command
    module Shutdown
      COMMAND = %w[xcrun simctl shutdown]

      # Shutdown a device
      #
      # @param device [SimCtl::Device] the device to shutdown
      # @return [void]
      def shutdown_device(device)
        Executor.execute([COMMAND, device.udid])
      end
    end
  end
end
