require 'simctl/object'

module SimCtl
  class Runtime < Object
    attr_reader :availability, :buildversion, :identifier, :name, :version
  end
end
