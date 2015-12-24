module SimCtl
  class Command
    module Boot
      COMMAND = %w[xcrun simctl boot]

      # Boots a device
      #
      # @param device [SimCtl::Device] the device to boot
      def boot_device(device)
        Executor.execute([COMMAND, device.udid])
      end
    end
  end
end
