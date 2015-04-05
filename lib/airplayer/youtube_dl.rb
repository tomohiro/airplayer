require 'shellwords'

module AirPlayer
  class YoutubeDl

    attr_reader :path

    def initialize(path = self.class.path || self.class.default_path)
      @path = path

      if @path
        File.exist?(@path) or raise "youtube-dl could not be found at #{@path}"
      end

      @output = '2> /dev/null'.freeze
    end

    def enabled?
      @path && ! @path.empty?
    end

    EXTRACT_EXTRACTOR_AND_URL = %r{
      (?<extractor>.+)\n # extractor name and new line
      \s+(:?.+) # the url if the extractor supports it
    }x

    GENERIC_EXTRACTOR = 'generic'.freeze

    def supports?(url)
      extractors = list_extractors(url).scan(EXTRACT_EXTRACTOR_AND_URL).flatten
      extractors.delete(GENERIC_EXTRACTOR)
      ! extractors.empty?
    end

    def list_extractors(*urls)
      execute('--list-extractors', *urls)
    end

    def get_url(url)
      execute('--get-url', url)
    end

    def get_filename(url)
      execute('--get-filename', url)
    end

    def get_title(url)
      execute('--get-title', url)
    end

    def execute(*args)
      return '' unless enabled?
      escape = Shellwords.method(:escape)
      parts = [ path, args.flat_map(&escape), @output ]
      %x`#{parts.flatten.join(' ')}`.strip
    end

    class << self
      attr_accessor :path

      def enabled?
        path && ! path.empty?
      end

      def default_path
        @default_path ||= `which youtube-dl 2> /dev/null`.strip
      end

      def get_url(uri)
        if enabled?
          new.get_url(uri)
        else
          uri
        end
      end

      def supports?(path)
        if enabled?
          new.supports?(path)
        end
      end

      def filename(url)
        if enabled?
          new.get_filename(url)
        else
          File.basename(url)
        end
      end

      def get_title(uri)
        if enabled?
          new.get_title(uri)
        else
          File.basename(uri)
        end
      end
    end
  end
end
