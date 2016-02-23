require 'simctl/object'

module SimCtl
  class Device < Object
    attr_reader :availability, :name, :os, :state, :udid

    def boot!
      SimCtl.boot_device(self)
    end

    def delete!
      SimCtl.delete_device(self)
    end

    def erase!
      SimCtl.erase_device(self)
    end

    def kill!
      SimCtl.kill_device(self)
    end

    def launch!
      SimCtl.launch_device(self)
    end

    def shutdown!
      SimCtl.shutdown_device(self)
    end
  end
end
