require 'timeout'
require 'uri'
require 'airplay'
require 'airplayer/progress_bar/base'

module AirPlayer
  class Player
    BufferingTimeoutError = Class.new(TimeoutError)

    def initialize
      @airplay      = Airplay::Client.new
      @player       = nil
      @progressbar  = nil
      @timeout      = 30
      @interval     = 1
      @total_sec    = 0
      @current_sec  = 0
    end

    def play(target)
      path = File.expand_path(target)
      if local_file? path
        video_server = AirPlayer::Server.new(path)
        Thread.start { video_server.start }
        uri = video_server.uri
      else
        uri = URI.encode(target)
      end

      puts "AirPlay: #{uri}"
      scrubbing(uri)
    rescue BufferingTimeoutError
      puts 'Timeout'
      abort
    end

    def scrubbing(uri)
      @player = @airplay.send_video(uri)

      format = '   %a |%b%i| %p%% %t'
      @progressbar = ProgressBar.create(:format => format , :title => :Waiting)

      until finish? do
        timeout @timeout, BufferingTimeoutError do
          buffering
        end

        playback_info
        @progressbar.progress = @current_sec
      end

      @player.stop
    end

    private
      def local_file?(path)
        File.exist? path
      end

      def playback_info
        scrub = @player.scrub
        @total_sec   = scrub['duration']
        @current_sec = scrub['position']
        sleep @interval
      end

      def buffering
        loop do
          playback_info
          redo unless buffering?
          @progressbar.title = :Streaming
          @progressbar.total = @total_sec
          break
        end
      end

      def buffering?
        0 < @total_sec
      end

      def finish?
        buffering? && @current_sec == @total_sec
      end
  end
end
