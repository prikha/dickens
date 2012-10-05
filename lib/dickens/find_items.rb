module Dickens
  class FindItem
    attr_accessor :dictionary, :word, :matching

    def initialize(string)
      /\n-->(?<dictionary>.*)\n-->(?<word>.*)\n/.match(list)

    end

  end
end