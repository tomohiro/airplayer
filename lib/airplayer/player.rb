require 'timeout'
require 'uri'
require 'airplay'
require 'airplayer/progress_bar/base'

module AirPlayer
  class Player
    BufferingTimeoutError = Class.new(TimeoutError)

    def self.play(*opts)
      new.play(*opts)
    rescue Airplay::Client::ServerNotFoundError
      abort '[ERROR] Apple device not found'
    end

    def initialize
      @airplay     = Airplay::Client.new
      @player      = nil
      @progressbar = nil
      @timeout     = 30
      @interval    = 1
      @total_sec   = 0
      @current_sec = 0
    end

    def play(target, repeat = false)
      loop do
        glob(target) do |video|
          send_play video
        end
        break unless repeat
      end
    end

    def reset
      @player.scrub(0)
      @player.resume

      @progressbar.reset
      @progressbar.resume
    end

    def stop
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

    private
      def glob(target)
        path = File.expand_path(target)
        if local_file? path
          yield path if !File.directory? path
          Dir.glob("#{path}/**/*").sort.each do |ph|
            yield ph if !File.directory? ph
          end
        else
          yield target
        end
      end

      def send_play(path)
        progress access_uri path
        stop
      rescue BufferingTimeoutError
        abort '[ERROR] Buffering timeout'
      end

      def progress(uri)
        puts "AirPlay: #{uri} to #{device.name}(#{device.ip})"
        @progressbar = ProgressBar.create(:format => '   %a |%b%i| %p%% %t', :title => :Waiting)
        @player = @airplay.send_video(uri)
p
        buffering
        @progressbar.progress = @current_sec while playing
      end

      def access_uri(path)
        if local_file? path
          @video_server = AirPlayer::Server.new(path)
          uri = @video_server.uri
          Thread.start { @video_server.start }
        else
          uri = URI.encode(path)
        end

        uri
      end

      def device
        @airplay.browse.first
      end

      def local_file?(path)
        File.exist? path
      end

      def buffering
        timeout @timeout, BufferingTimeoutError do
          loop do
            playing
            redo unless buffering?
            @progressbar.title = :Streaming
            @progressbar.total = @total_sec
            break
          end
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

      def buffering?
        0 < @total_sec && 0 < @current_sec
      end
  end
end
