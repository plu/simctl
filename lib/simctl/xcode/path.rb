module SimCtl
  module Xcode
    class Path
      HOME=`xcode-select -p`.chomp

      class << self
        def home
          HOME
        end
      end
    end
  end
end
