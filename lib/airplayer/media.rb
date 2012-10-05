require 'uri'

module AirPlayer
  class Media
    attr_reader :title, :path, :type

    def initialize(target)
      path   = File.expand_path(target)
      @title = File.basename(path)

      if File.exist? path
        @video_server = AirPlayer::Server.new(path)
        @path = @video_server.uri
        @type = :file
      else
        @path = URI.encode(target)
        @type = :url
      end
    end

    def open
      Thread.start { @video_server.start } if file?
      @path
    end

    def close
      @video_server.stop if file?
    end

    def file?
      @type == :file
    end

    def url?
      @type == :url
    end
  end
end
