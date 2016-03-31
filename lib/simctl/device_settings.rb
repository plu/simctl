require 'simctl/helper'

module SimCtl
  class DeviceSettings
    include SimCtl::Helper

    attr_reader :path

    def initialize(path)
      @path = path
    end

    # Disables the keyboard helpers
    #
    # @return [void]
    def disable_keyboard_helpers!
      edit_plist(path.preferences_plist) do |plist|
        %w(
          KeyboardAllowPaddle
          KeyboardAssistant
          KeyboardAutocapitalization
          KeyboardAutocorrection
          KeyboardCapsLock
          KeyboardCheckSpelling
          KeyboardPeriodShortcut
          KeyboardPrediction
          KeyboardShowPredictionBar
        ).each do |key|
          plist[key] = false
        end
      end
    end

    # Sets the device language
    #
    # @return [void]
    def set_language(language)
      edit_plist(path.global_preferences_plist) do |plist|
        key = 'AppleLanguages'
        plist[key] = [] unless plist.has_key?(key)
        plist[key].unshift(language).uniq!
      end
    end
  end
end
