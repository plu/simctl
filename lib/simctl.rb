require 'simctl/command'
require 'simctl/device'
require 'simctl/device_type'
require 'simctl/helper'
require 'simctl/list'
require 'simctl/runtime'

module SimCtl
  class << self
    include Helper

    def command
      return @command if defined?(@command)
      @command = SimCtl::Command.new
    end

    # Edit `Library/Preferences/com.apple.iphonesimulator.plist`
    #
    # @return [void]
    # @yield [Hash] The hash of the preferences plist. Modifications will be written to the file.
    def edit_iphonesimulator_plist(&block)
      edit_plist(File.join(ENV['HOME'], 'Library/Preferences/com.apple.iphonesimulator.plist'), &block)
    end

    private

    def respond_to_missing?(method_name, include_private=false)
      command.respond_to?(method_name, include_private)
    end

    def method_missing(method_name, *args, &block)
      if command.respond_to?(method_name)
        return command.send(method_name, *args, &block)
      end
      super
    end
  end
end
