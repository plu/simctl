module SimCtl
  class Command
    module Boot
      COMMAND = %w[xcrun simctl boot]

      def boot_device(device)
        Executor.execute([COMMAND, device.udid])
      end
    end
  end
end
