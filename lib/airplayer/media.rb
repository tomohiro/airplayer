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
  SUPPORTED_MIME_TYPES = %w[
    application/mp4
    video/mp4
    video/vnd.objectvideo
    video/MP2T
    video/quicktime
    video/mpeg4
  ]

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

    def self.playable?(path)
      MIME::Types.type_for(path).each do |mimetype|
        return SUPPORTED_MIME_TYPES.include? mimetype
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
  end
end
