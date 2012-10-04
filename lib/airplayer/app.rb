require 'thor'

module AirPlayer
  class App < Thor
    desc 'play <URI|FILE|DIR> [-r|--repeat] ', 'Play video(URI or local video file path or video directory)'
    method_option :repeat, :aliases => '-r', :desc => 'Repeat play', :type => :boolean
    def play(target)
      controller = Controller.new
      playlist   = Playlist.new
      playlist.add(target)

      if Dir.exists?(target)
        abort '[ERROR] Sorry, repeat option(-r,--repeat) is not supported.' if options.repeat?
        playlist.entries do |file|
          controller.play(file)
        end
      else
        controller.play(playlist.first, options.repeat?)
      end
    end

    map '--version' => :version
    desc 'version, --version', 'Display version'
    def version
      puts VERSION
    end
  end
end
