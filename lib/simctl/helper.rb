require 'cfpropertylist'

module SimCtl
  module Helper
    # Edit some plist
    #
    # @param [String] Path to the plist
    # @return [void]
    # @yield [Hash] The hash of the plist. Modifications will be written to the file.
    def edit_plist(path, &block)
      plist = File.exists?(path) ? CFPropertyList::List.new(file: path) : CFPropertyList::List.new
      content = CFPropertyList.native_types(plist.value) || {}
      yield content
      plist.value = CFPropertyList.guess(content)
      plist.save(path, CFPropertyList::List::FORMAT_BINARY)
    end
  end
end
