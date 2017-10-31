module SimCtl
  module Xcode
    class Path
      HOME = `xcode-select -p`.chomp

      class << self
        def home
          HOME
        end

        def sdk_root
          File.join(HOME, 'Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk')
        end

        def runtime_profiles
          if Xcode::Version.gte? '9.0'
            File.join(HOME, 'Platforms/iPhoneOS.platform/Developer/Library/CoreSimulator/Profiles/Runtimes/')
          else
            File.join(HOME, 'Platforms/iPhoneSimulator.platform/Developer/Library/CoreSimulator/Profiles/Runtimes/')
          end
        end
      end
    end
  end
end
