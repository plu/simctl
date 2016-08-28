require 'simctl/command/boot'
require 'simctl/command/create'
require 'simctl/command/delete'
require 'simctl/command/erase'
require 'simctl/command/install'
require 'simctl/command/kill'
require 'simctl/command/launch'
require 'simctl/command/list'
require 'simctl/command/rename'
require 'simctl/command/reset'
require 'simctl/command/shutdown'
require 'simctl/executor'

module SimCtl
  class Command
    attr_accessor :device_set_path

    include SimCtl::Command::Boot
    include SimCtl::Command::Create
    include SimCtl::Command::Delete
    include SimCtl::Command::Erase
    include SimCtl::Command::Install
    include SimCtl::Command::Kill
    include SimCtl::Command::Launch
    include SimCtl::Command::List
    include SimCtl::Command::Rename
    include SimCtl::Command::Reset
    include SimCtl::Command::Shutdown

    def command_for(*arguments)
      command = %w[xcrun simctl]
      command += ['--set', device_set_path] unless device_set_path.nil?
      command += arguments
      command
    end
  end
end
