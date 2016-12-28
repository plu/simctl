require 'shellwords'

module SimCtl
  class Command
    module Spawn
      # Spawn a process on a device
      #
      # @param device [SimCtl::Device] the device to spawn a process on
      # @param path [String] path to executable
      # @param args [Array] arguments for the executable
      # @return [String] standard output the spawned process generated
      def spawn(device, path, args=[], opts={})
        Executor.execute(command_for('spawn', device.udid, Shellwords.shellescape(path), *args.map{|a| Shellwords.shellwords(a)})) do |output|
          output
        end
      end
    end
  end
end
