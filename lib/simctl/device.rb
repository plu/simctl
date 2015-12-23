require 'simctl/object'

module SimCtl
  class Device < Object
    attr_reader :availability, :name, :os, :state, :udid

    def delete!
      SimCtl.delete_device(self)
    end

    def erase!
      SimCtl.erase_device(self)
    end
  end
end
