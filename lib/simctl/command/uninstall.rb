require 'shellwords'

module SimCtl
  class Command
    module Uninstall
      COMMAND = %w[xcrun simctl uninstall]

      # Uninstall an app on a device
      #
      # @param device [SimCtl::Device] the device the app should be uninstalled from
      # @param path Absolute path to the app that should be uninstalled
      # @return [void]
      def uninstall_app(device, path)
        Executor.execute(command_for('uninstall', device.udid, Shellwords.shellescape(path)))
      end
    end
  end
end
