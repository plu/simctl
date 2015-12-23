require 'simctl/command'
require 'simctl/device'
require 'simctl/device_type'
require 'simctl/list'
require 'simctl/runtime'

module SimCtl
  class << self
    def command
      return @command if defined?(@command)
      @command = SimCtl::Command.new
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
