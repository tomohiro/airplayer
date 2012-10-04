require 'timeout'
require 'uri'
require 'airplay'
require 'airplayer/progress_bar/base'

module AirPlayer
  class Controller
    BufferingTimeoutError = Class.new(TimeoutError)

    def self.play(*opts)
      new.play(*opts)
    rescue Airplay::Client::ServerNotFoundError
      abort '[ERROR] Apple device not found'
    end

    def initialize
      @airplay      = Airplay::Client.new
      @playlist     = Playlist.new
      @player       = nil
      @video_server = nil
      @progressbar  = nil
      @timeout      = 30
      @interval     = 1
      @total_sec    = 0
      @current_sec  = 0
    end

    def play(target, repeat = false)
      @playlist.add(target)
      loop do
        @playlist.entries do |video|
          progress(access_uri(video))
          pause
        end
        break unless repeat
      end
    rescue BufferingTimeoutError
      abort '[ERROR] Buffering timeout'
    end

    def pause
      unless @player.nil?
        @player.stop
      end

      unless @progressbar.nil?
        @progressbar.title = :Complete
        @progressbar.finish
      end

      unless @video_server.nil?
        @video_server.stop
      end
    end

    def reset
      @player.scrub(0)
      @player.resume

      @progressbar.reset
      @progressbar.resume
    end

    private
      def progress(uri)
        puts "AirPlay: #{uri} to #{device.name}(#{device.ip})"
        @progressbar = ProgressBar.create(:format => '   %a |%b%i| %p%% %t')
        @player = @airplay.send_video(uri)

        buffering
        @progressbar.progress = @current_sec while playing
      end

      def access_uri(path)
        if File.exist? path
          @video_server = AirPlayer::Server.new(path)
          @video_server.start
          uri = @video_server.uri
        else
          uri = URI.encode(path)
        end
      end

      def device
        @airplay.browse.first
      end

      def buffering
        timeout @timeout, BufferingTimeoutError do
          @progressbar.title = :Buffering until playing
          @progressbar.title = :Streaming
          @progressbar.total = @total_sec
        end
      end

      def playing
        scrub = @player.scrub
        @total_sec   = scrub['duration']
        @current_sec = scrub['position']
        sleep @interval
        progress?
      end

      def progress?
        0 < @current_sec && @current_sec < @total_sec
      end
  end
end
