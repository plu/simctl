module SimCtl
  module Xcode
    class Path
      HOME=`xcode-select -p`.chomp

      class << self
        def home
          HOME
        end

        def sdk_root
          File.join(HOME, 'Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk')
        end
      end
    end
  end
end
