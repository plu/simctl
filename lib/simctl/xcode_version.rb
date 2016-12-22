module SimCtl
  module XcodeVersion
    VERSION = Gem::Version.new(`xcodebuild -version`.scan(/Xcode (\S+)/).flatten.first)

    class << self
      def version
        VERSION
      end

      def gte?(version)
        return VERSION >= Gem::Version.new(version)
      end
    end
  end
end
