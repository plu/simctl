module SimCtl
  class Command
    module Delete
      COMMAND = %w[xcrun simctl delete]

      def delete_device(device)
        Executor.execute([COMMAND, device.udid])
      end
    end
  end
end
