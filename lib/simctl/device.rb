require 'cfpropertylist'
require 'ostruct'
require 'simctl/device_path'
require 'simctl/object'
require 'timeout'

module SimCtl
  class Device < Object
    attr_reader :availability, :name, :os, :state, :udid

    def boot!
      SimCtl.boot_device(self)
    end

    def delete!
      SimCtl.delete_device(self)
    end

    def devicetype
      @devicetype ||= SimCtl.devicetype(identifier: plist.deviceType)
    end

    def disable_keyboard_helpers!
      path.edit path.preferences_plist do |plist|
        %w(
          KeyboardPeriodShortcut
          KeyboardAutocapitalization
          KeyboardCheckSpelling
          KeyboardAssistant
          KeyboardAutocorrection
          KeyboardPrediction
          KeyboardShowPredictionBar
          KeyboardCapsLock
        ).each do |key|
          plist[key] = false
        end
        plist
      end
    end

    def erase!
      SimCtl.erase_device(self)
    end

    def kill!
      SimCtl.kill_device(self)
    end

    def launch!(scale=1.0, opts={})
      SimCtl.launch_device(self, scale, opts)
    end

    def path
      @path ||= DevicePath.new(udid)
    end

    def rename!(name)
      SimCtl.rename_device(self, name)
    end

    def reset!
      SimCtl.reset_device name, devicetype, runtime
    end

    def runtime
      @runtime ||= SimCtl.runtime(identifier: plist.runtime)
    end

    def shutdown!
      SimCtl.shutdown_device(self)
    end

    def state
      @state.downcase.to_sym
    end

    def wait!(timeout=15)
      Timeout::timeout(timeout) do
        loop do
          break if yield SimCtl.device(udid: udid)
        end
      end
    end

    def ==(other)
      return false if other.nil?
      return false unless other.kind_of? Device
      other.udid == udid
    end

    private

    def plist
      @plist ||= OpenStruct.new(CFPropertyList.native_types(CFPropertyList::List.new(file: path.device_plist).value))
    end

  end
end
