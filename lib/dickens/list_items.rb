module Dickens
  class ListItem
    attr_accessor :name, :word_count
    def self.parse(stdout)
      stdout.map!{|item|
        next if stdout.index(item)==0
        self.new(item)
      }.compact!
    end

    def initialize(string)
      @name, @word_count = string.gsub(/\n/,"").split("    ")
      @word_count= @word_count.to_i
    end

  end
end