module SimCtl
  module Xcode
    class Version
      VERSION = Gem::Version.new(`xcodebuild -version`.scan(/Xcode (\S+)/).flatten.first)

      class << self
        def gte?(version)
          VERSION >= Gem::Version.new(version)
        end
      end
    end
  end
end
