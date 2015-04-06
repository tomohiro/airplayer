require 'ruby-progressbar'

module AirPlayer
  class Controller
    def initialize(options = { device: nil })
      @device      = Device.get(options[:device])
      @player      = nil
      @progressbar = nil
    end

    def play(media)
      puts " Source: #{media.path}"
      puts "  Title: #{media.title}"
      puts " Device: #{@device.name} (Resolution: #{@device.info.resolution})"

      @progressbar = ProgressBar.create(format: '   %a |%b%i| %p%% %t')
      @player.progress -> playback {
        @progressbar.title    = 'Streaming'
        @progressbar.progress = playback.percent if playback.percent
      }
      @player = @device.play(media.path)
      @player.wait
    end

    def pause
      if @player
        @player.stop
      end

      if @progressbar
        @progressbar.title = 'Complete'
        @progressbar.finish
      end
    end
  end
end
