require 'uri'
require 'mime/types'

module AirPlayer
  # http://developer.apple.com/library/ios/#documentation/AudioVideo/Conceptual/AirPlayGuide/PreparingYourMediaforAirPlay/PreparingYourMediaforAirPlay.html
  #
  # File Extension | MIME type       | Ruby `mime-types`
  # -------------- | --------------- | -----------------------------
  # .ts            | video/MP2T      | video/MP2T 
  # .mov           | video/quicktime | video/quicktime
  # .m4v           | video/mpeg4     | video/vnd.objectvideo
  # .mp4           | video/mpeg4     | application/mp4, video/mp4
  SUPPORTED_MIME_TYPES = %w(
    application/mp4
    video/mp4
    video/vnd.objectvideo
    video/MP2T
    video/quicktime
    video/mpeg4
  )

  SUPPORTED_DOMAINS = %w(
    youtube
  )

  class Media
    attr_reader :title, :path, :type

    def initialize(target)
      path = File.expand_path(target)

      if File.exist? path
        @video_server = AirPlayer::Server.new(path)
        @path  = @video_server.uri
        @title = File.basename(path)
        @type  = :file
      else
        uri = URI.encode(target)
        @path  = online_media_path(uri)
        @title = online_media_title(uri)
        @type  = :url
      end
    end

    def self.playable?(path)
      MIME::Types.type_for(path).each do |mimetype|
        return SUPPORTED_MIME_TYPES.include? mimetype
      end

      host = URI.parse(path).host
      SUPPORTED_DOMAINS.each do |domain|
        return host =~ /#{domain}/
      end

      false
    end

    def open
      @video_server.start if file?
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

    private
      def online_media_path(uri)
        case URI.parse(uri).host
        when /youtube/
          uri = %x{youtube-dl -g #{uri}}
        else
          uri
        end
      end

      def online_media_title(uri)
        case URI.parse(uri).host
        when /youtube/
          title = %x{youtube-dl -e #{uri}}
        else
          title
        end
      end
  end
end
