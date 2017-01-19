require 'naturally'
require 'simctl/object'

module SimCtl
  class Runtime < Object
    attr_reader :availability, :buildversion, :identifier, :name, :type, :version

    def type
      @type ||= name.split("\s").first.downcase.to_sym
    end

    def ==(other)
      return false if other.nil?
      return false unless other.kind_of? Runtime
      other.identifier == identifier
    end

    def gte?(other_version)
      return false if other_version.nil?
      return false unless other_version.kind_of? String
      Gem::Version.new(version) >= Gem::Version.new(other_version)
    end

    # Returns the latest available runtime
    #
    # @param name [String] type (ios, watchos, tvos)
    # @return [SimCtl::Runtime] the latest available runtime
    def self.latest(type)
      Naturally.sort_by(SimCtl.list_runtimes.where(name: %r|#{type}|i), :version).last
    end
  end
end
