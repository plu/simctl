require 'simctl/object'

module SimCtl
  class Device < Object
    attr_reader :availability, :name, :os, :state, :udid

    # Boot the device
    def boot!
      SimCtl.boot_device(self)
    end

    # Delete the device
    def delete!
      SimCtl.delete_device(self)
    end

    # Erase the device
    def erase!
      SimCtl.erase_device(self)
    end

    def kill!
      SimCtl.kill_device(self)
    end

    def launch!
      SimCtl.launch_device(self)
    end

    # Shutdown the device
    def shutdown!
      SimCtl.shutdown_device(self)
    end
  end
end
