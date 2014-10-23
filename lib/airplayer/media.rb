require 'uri'
require 'mime/types'

module AirPlayer
  # http://developer.apple.com/library/ios/#documentation/AudioVideo/Conceptual/AirPlayGuide/PreparingYourMediaforAirPlay/PreparingYourMediaforAirPlay.html
  #
  # File Extension | MIME type       | Ruby `mime-types`
  # -------------- | --------------- | -----------------------------
  # .ts            | video/MP2T      | video/mp2t
  # .mov           | video/quicktime | video/quicktime
  # .m4v           | video/mpeg4     | video/m4v
  # .mp4           | video/mpeg4     | application/mp4, video/mp4
  SUPPORTED_MIME_TYPES = %w(
    application/mp4
    video/mp4
    video/m4v
    video/mp2t
    video/quicktime
    video/mpeg4
  )

  SUPPORTED_DOMAINS = %w(
    youtube
    youtu.be
  )

  class Media
    attr_reader :title, :path, :type

    def initialize(target)
      path = File.expand_path(target)

      if File.exist? path
        @path  = path
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
      MIME::Types.of(path).map(&:simplified).each do |mimetype|
        return SUPPORTED_MIME_TYPES.include?(mimetype)
      end

      host = URI.parse(URI.escape(path)).host
      SUPPORTED_DOMAINS.each do |domain|
        return true if host =~ /#{domain}/
      end

      false
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
        when /youtube|youtu\.be/
          uri = `youtube-dl -g #{uri}`
        else
          uri
        end
      end

      def online_media_title(uri)
        case URI.parse(uri).host
        when /youtube|youtu\.be/
          title = `youtube-dl -e #{uri}`
        else
          title = File.basename(uri)
        end
      end
  end
end
