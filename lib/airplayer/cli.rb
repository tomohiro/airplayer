require 'uri'
require 'ruby-progressbar'

module AirPlayer
  class CLI
    def self.play(*args)
      self.new.play(args.first)
    end

    def initialize
      @airplay = Airplay::Client.new
      @timeout = 30
    end

    def play(uri)
      usage if uri.nil?
      puts "AirPlay: #{uri}\n=="

      interval     = 1
      elapsed_time = 0
      uri          = URI.encode(uri)
      player       = @airplay.send_video(uri)

      progressbar  = nil
      format       = '%a |%b%i| %p%% %t'
      ProgressBar.create(:format => format , :title => :Streaming)

      loop do
        scrub    = player.scrub
        duration = scrub['duration']
        position = scrub['position']

        sleep interval
        elapsed_time += interval

        if duration == 0
          usage if elapsed_time > @timeout
          redo
        end

        progressbar ||= ProgressBar.create(:format => format, :title => :Streaming, :total => duration)
        progressbar.progress = position

        if duration == position
          player.stop
          break
        end
      end
    end

    private
      def usage
        puts 'Usage'
        puts '  airplayer http://example.com/video.mp4'
        abort
      end
  end
end
