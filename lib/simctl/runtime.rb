require 'simctl/object'

module SimCtl
  class Runtime < Object
    attr_reader :availability, :buildversion, :identifier, :name, :version

    def ==(other)
      other.identifier == identifier
    end

    # Returns the latest available runtime
    #
    # @param name [String] type (ios, watchos, tvos)
    # @return [SimCtl::Runtime] the latest available runtime
    def self.latest(type)
      SimCtl.list_runtimes.where(name: %r|#{type}|i).sort_by {|r| r.version}.reverse.first
    end
  end
end
