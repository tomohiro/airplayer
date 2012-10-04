require 'thor'

module AirPlayer
  class App < Thor
    desc 'play <URI|FILE|DIR> [-r|--repeat] ', 'Play video(URI or local video file path or video directory)'
    method_option :repeat, :aliases => '-r', :desc => 'Repeat play', :type => :boolean
    def play(target)
      playlist   = Playlist.new
      controller = Controller.new
      if Dir.exists?(target)
        abort 'Sorry, repeat option(-r,--repeat) is not supported.' if options.repeat?
        playlist.add(target)
        playlist.entries do |file|
          controller.play(file)
        end
      else
        playlist.add(target)
        controller.play(target, options.repeat?)
      end
    end

    map '--version' => :version
    desc 'version, --version', 'Display version'
    def version
      puts VERSION
    end
  end
end
