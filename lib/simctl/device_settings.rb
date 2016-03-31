require 'cfpropertylist'

module SimCtl
  class DeviceSettings
    attr_reader :path

    def initialize(path)
      @path = path
    end

    # Disables the keyboard helpers
    #
    # @return [void]
    def disable_keyboard_helpers!
      edit(path.preferences_plist) do |plist|
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
        plist
      end
    end

    private

    def edit(path, &block)
      plist = File.exists?(path) ? CFPropertyList::List.new(file: path) : CFPropertyList::List.new
      content = CFPropertyList.native_types(plist.value) || {}
      plist.value = CFPropertyList.guess(yield content)
      plist.save(path, CFPropertyList::List::FORMAT_BINARY)
    end
  end
end
