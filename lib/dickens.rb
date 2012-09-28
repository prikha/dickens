require "dickens/version"

require 'rbconfig'
require RbConfig::CONFIG['target_os'] == 'mingw32' && !(RUBY_VERSION =~ /1.9/) ? 'win32/open3' : 'open3'

require 'active_support/core_ext/class/attribute_accessors'

begin
  require 'active_support/core_ext/object/blank'
rescue LoadError
  require 'active_support/core_ext/blank'
end

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


    #Использование:
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
        word.to_s
        invoke(word)
      end

      protected

      def invoke(word)
        command = [@@executable, prepare_options, word].join(" ")
        stdin, stdout, stderr = Open3.popen3(command)
        return stdout.readlines.join
      end

      def prepare_options
        raise WrongFormatError unless @@config.is_a? Hash
        options = normalize_options(@@config)
        options.flatten
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
        value.is_a?(TrueClass) ? nil : value.to_s
      end

    end



  end
end
