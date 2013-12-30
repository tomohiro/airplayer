require 'thor'

module AirPlayer
  class App < Thor
    desc 'play <URI|PATH> [-r|--repeat] [-s|--shuffle] [-d=|--device=]', 'Play video(URI[Podcast URI, YouTube] or Path[local video file, directory])'
    method_option :repeat,  aliases: '-r', desc: 'Repeat play',   type: :boolean
    method_option :shuffle, aliases: '-s', desc: 'Shuffle play',  type: :boolean
    method_option :device,  aliases: '-d', desc: 'Device number', type: :numeric
    def play(target)
      controller = Controller.new(device: options.fetch('device', 0))
      Playlist.new(options).add(target).entries do |media|
        controller.play(media)
        controller.pause
      end
    end

    desc 'devices', 'Show AirPlay devices'
    def devices
      Device.devices.each_with_index do |device, number|
        puts "#{number}: #{device.name} (Resolution: #{device.info.resolution}, Version: #{device.info.os_version}, IP: #{device.address})"
      end
    end

    map '--version' => :version
    desc 'version, --version', 'Display version'
    def version
      puts VERSION
    end
  end
end
