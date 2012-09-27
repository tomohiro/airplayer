require 'thor'

module AirPlayer
  class App < Thor
    desc 'play <URI|FILE> [-r|--repeat]', 'Play video(URI or local video file path)'
    method_option :repeat, :aliases => '-r', :desc => 'Repeat play'
    def play(uri)
      Player.play(uri, options.repeat?)
    end

    map '--version' => :version
    desc 'version, --version', 'Display version'
    def version
      puts VERSION
    end
  end
end
