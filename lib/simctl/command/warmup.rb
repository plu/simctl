module SimCtl
  class Command
    module Warmup
      # Warms up a device and waits for it to be ready
      #
      # @param devicetype [String] device type string
      # @param runtime [String] runtime string
      # @param timeout [Integer] timeout in seconds to wait until device is ready
      # @return [SimCtl::Device]
      def warmup(devicetype, runtime, timeout=120)
        device = device(devicetype: devicetype(name: devicetype), runtime: runtime(name: runtime))
        raise DeviceNotFound.new("Could not find device with type '#{devicetype}' and runtime '#{runtime}'") if device.nil?
        device.launch
        device.wait(timeout) {|d| d.state == :booted && d.ready?}
        device
      end
    end
  end
end
