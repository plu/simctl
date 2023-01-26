module SimCtl
  class List < Array
    # Filters an array of objects by a given hash. The keys of
    # the hash must be methods implemented by the objects. The
    # values of the hash are compared to the values the object
    # returns when calling the methods.
    #
    # @param filter [Hash] the filters that should be applied
    # @return [Array] the filtered array.
    def where(filter)
      return self if filter.nil?
      select do |item|
        filter.each do |key, value|
          return false unless case value
                                when Regexp
                                  item.send(key) =~ value
                                else
                                  item.send(key) == value
                              end
        end
        true
      end
    end
  end
end
