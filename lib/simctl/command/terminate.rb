require 'shellwords'

module SimCtl
  class Command
    module Terminate
      # Terminates an app on the given device
      #
      # @param device [SimCtl::Device] the device with the app to terminate
      # @param identifier [String] the app identifier
      # @param args [Array] optional terminate arguments
      # @return [void]
      def terminate_app(device, identifier, args=[])
        terminate_args = args.map {|arg| Shellwords.shellescape arg}
        Executor.execute(command_for('terminate', terminate_args, device.udid, identifier))
      end
    end
  end
end