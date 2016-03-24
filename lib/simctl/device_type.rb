require 'simctl/object'

module SimCtl
  class DeviceType < Object
    attr_reader :identifier, :name

    def ==(other)
      other.identifier == identifier
    end
  end
end
