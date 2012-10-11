
module Dickens
  class StarDict
    @@executable = "sdcv"
    @@config = {
        :use_dict => false,
        :utf8_input => true,
        :utf8_output => true,
        :non_interactive => true,
        :data_dir=>false
    }
    cattr_accessor :config, :executable


    ##Использование:
    #    sdcv [ПАРАМЕТР...]  words
    #
    #Параметры приложения:
    #-v, --version                  display version information and exit
    #-l, --list-dicts               display list of available dictionaries and exit
    #-u, --use-dict=bookname        for search use only dictionary with this bookname
    #-n, --non-interactive          for use in scripts
    #-0, --utf8-output              output must be in utf8
    #-1, --utf8-input               input of sdcv in utf8
    #-2, --data-dir=path/to/dir     use this directory as path to stardict data directory

    class << self
      def find(word)
        command = [@@executable, prepare_options, word.to_s].join(" ")
        status, *response = invoke(command)
        puts status
        Dickens::FindItem.parse(response.join(""), word)
      end

      def where(word, dictionaries=[])
        return find(word) if dictionaries.empty? or !dictionaries.is_a?(Array)
        cache=@@config
        result=[]
        dictionaries.each do |d|
          @@config[:use_dict] = d.try(:name) || d
          result+= find(word)
        end
        @@config=cache
        result
      end

      def list
        Dickens::ListItem.parse invoke([@@executable, "--list-dicts"].join(" "))
      end

      protected

      def invoke(command)
        stdin, stdout, stderr = Open3.popen3(command)
        return stdout.readlines
      end

      def prepare_options
        raise WrongFormatError unless @@config.is_a? Hash
        normalize_options(@@config).flatten
      end

      def normalize_options(options)
        normalized_options = {}
        options.each do |key, value|
          next unless value
          normalized_key = "--#{normalize_arg key}"
          normalized_options[normalized_key] = normalize_value(value)
        end
        normalized_options
      end

      def normalize_arg(arg)
        arg.to_s.downcase.gsub(/[^a-z0-9]/,'-')
      end

      def normalize_value(value)
        value.is_a?(TrueClass) ? nil : "\"#{value.to_s}\""
      end

    end
  end
end