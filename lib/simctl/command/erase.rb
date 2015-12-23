module SimCtl
  class Command
    module Erase
      COMMAND = %w[xcrun simctl erase]

      def erase_device(device)
        Executor.execute([COMMAND, device.udid])
      end
    end
  end
end


