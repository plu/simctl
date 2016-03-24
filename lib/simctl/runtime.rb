require 'simctl/object'

module SimCtl
  class Runtime < Object
    attr_reader :availability, :buildversion, :identifier, :name, :version

    def ==(other)
      other.identifier == identifier
    end
  end
end
