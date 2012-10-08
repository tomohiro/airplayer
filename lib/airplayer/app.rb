require 'thor'

module AirPlayer
  class App < Thor
    desc 'play <URI|FILE|DIR> [-r|--repeat] [-s|--shuffle]', 'Play video(URI or local video file path or video directory)'
    method_option :repeat, :aliases => '-r', :desc => 'Repeat play', :type => :boolean
    method_option :shuffle, :aliases => '-s', :desc => 'Random play', :type => :boolean
    def play(target)
      controller = Controller.new
      Playlist.new.add(target, options.shuffle).entries(options.repeat) do |media|
        controller.play(media)
      end
    end

    map '--version' => :version
    desc 'version, --version', 'Display version'
    def version
      puts VERSION
    end
  end
end
