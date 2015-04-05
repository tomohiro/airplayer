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

  class Media
    attr_reader :title, :path, :type

    def initialize(target)
      path = File.expand_path(target)

      if File.exist? path
        @path  = path
        @title = File.basename(path)
        @type  = :file
      else
        @path  = YoutubeDl.get_url(target)
        @title = YoutubeDl.get_title(target)
        @type  = :url
      end
    end

    class << self
      def playable?(path)
        if is_url?(path)
          YoutubeDl.supports?(path) || supported_mime_type?(YoutubeDl.filename(path))
        else
          supported_mime_type?(path)
        end
      end

      def is_url?(path)
        uri = URI(path)
        uri.scheme && uri.absolute?
      rescue URI::InvalidURIError
        false
      end

      def supported_mime_type?(path)
        MIME::Types.of(path).map(&:simplified).each do |mimetype|
          return SUPPORTED_MIME_TYPES.include?(mimetype)
        end

        false
      end
    end


    def file?
      @type == :file
    end

    def url?
      @type == :url
    end
  end
end
