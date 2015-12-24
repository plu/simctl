module SimCtl
  class Command
    module Delete
      COMMAND = %w[xcrun simctl delete]

      # Delete a device
      #
      # @param device [SimCtl::Device] the device to delete
      def delete_device(device)
        Executor.execute([COMMAND, device.udid])
      end
    end
  end
end
