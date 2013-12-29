require 'ruby-progressbar'

module AirPlayer
  class Controller
    def initialize(options = { device: nil })
      @device      = Airplay[select_device(options[:device]).name]
      @player      = nil
      @progressbar = nil
    end

    def play(media)
      raise TypeError unless media.is_a? Media

      puts
      puts "  Source: #{media.path}"
      puts " Playing: #{media.title}"
      puts "  Device: #{@device.name} [#{@device.info.resolution}]"

      @progressbar = ProgressBar.create(title: @device.name, format: '   %a |%b%i| %p%% %t')
      @player = @device.play(media.path)
      @player.progress -> playback {
        @progressbar.progress = playback.percent if playback.percent
      }
      @player.wait
    rescue TypeError
      abort '[ERROR] Not media class'
    rescue
      abort 'Play stopped'
    end

    def pause
      @player.stop if @player
      @progressbar.finish if @progressbar
    end

    private
      def select_device(device_number = nil)
        device_number ||= 0
        device = Device.new

        if device.exist?(device_number)
          device.get(device_number)
        else
          puts "Device number #{device_number} is not found. Use default device"
          device.default
        end
      end
  end
end
