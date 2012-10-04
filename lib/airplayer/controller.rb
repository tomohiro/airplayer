require 'timeout'
require 'airplay'
require 'airplayer/progress_bar/base'

module AirPlayer
  class Controller
    BufferingTimeoutError = Class.new(TimeoutError)
    MediaTypeError        = Class.new(TypeError)

    def initialize
      @airplay      = Airplay::Client.new
      @device       = @airplay.browse.first
      @player       = nil
      @progressbar  = nil
      @timeout      = 30
      @interval     = 1
      @total_sec    = 0
      @current_sec  = 0
    rescue Airplay::Client::ServerNotFoundError
      abort '[ERROR] Apple device not found'
    end

    def play(media, repeat = false)
      raise MediaTypeError unless media.respond_to?(:open)

      puts "\n Source: #{media.path}"
      puts "  Title: #{media.title}"
      puts " Device: #{@device.name}(#{@device.ip})"

      @progressbar = ProgressBar.create(:format => '   %a |%b%i| %p%% %t')
      @player = @airplay.send_video(media.open)

      loop do
        buffering
        @progressbar.progress = @current_sec while playing
        @progressbar.title = :Complete
        break unless repeat
        replay
      end
      pause
      media.close
    rescue BufferingTimeoutError
      abort '[ERROR] Buffering timeout'
    rescue MediaTypeError
      abort '[ERROR] Not supported media type'
    end

    def pause
      @player.stop        if @player
      @progressbar.finish if @progressbar
    end

    def replay
      @player.scrub(0)
      @player.resume

      @progressbar.reset
      @progressbar.resume
    end

    private
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
