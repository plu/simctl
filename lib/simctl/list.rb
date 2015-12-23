module SimCtl
  class List < Array
    def where(hash)
      select do |item|
        matches = true
        hash.each do |key, value|
          matches &= item.send(key) == value
        end
        matches
      end
    end
  end
end
