module SimCtl
  module Xcode
    class Version

      class << self
        def gte?(version)
          thing = Gem::Version.new(`xcodebuild -version`.scan(/Xcode (\S+)/).flatten.first)

          thing >= Gem::Version.new(version)
        end
      end
    end
  end
end
