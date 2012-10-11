module Dickens
  class FindItem
    attr_accessor :article, :dictionary, :word, :matching

    def initialize(array, word)
      extract = /-->(?<dic>.*)\n-->(?<w>.*)\n\n(?<a>[\W|\w|.]*)/.match(array)
      @dictionary= extract[:dic]
      @word= extract[:w]
      @article= extract[:a].strip
      @matching= (@word == word)
    end

    def to_s
      "-->#{dictionary}\n-->#{word}\n===\n#{article}"
    end

    def self.parse(string,word)
      out=[]

      #split console output by article delimiter but preserve the delimiter info
      #then slice them by pairs [delimiter, article] and join back
      #then initialize FindItems
      string.split(/(-->.*\n-->.*\n)/).reject(&:empty?).each_slice(2).map(&:join).each do |e|
        out<<Dickens::FindItem.new(e, word)
      end
      out
    end
  end
end