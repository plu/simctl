require 'simctl/command/boot'
require 'simctl/command/create'
require 'simctl/command/delete'
require 'simctl/command/erase'
require 'simctl/command/list'
require 'simctl/command/shutdown'
require 'simctl/executor'

module SimCtl
  class Command
    include SimCtl::Command::Boot
    include SimCtl::Command::Create
    include SimCtl::Command::Delete
    include SimCtl::Command::Erase
    include SimCtl::Command::List
    include SimCtl::Command::Shutdown
  end
end
