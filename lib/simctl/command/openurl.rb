require 'shellwords'

module SimCtl
  class Command
    module OpenUrl
      COMMAND = %w[xcrun simctl openurl]

      # Opens a url
      #
      # @param device [SimCtl::Device] the device the app should be installed on
      # @param url The url to open on the tdevice
      # @return [void]
      def open_url(device, url)
        Executor.execute(command_for('openurl', device.udid, Shellwords.shellescape(url)))
      end
    end
  end
end
