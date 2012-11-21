require 'thor'

module AirPlayer
  class App < Thor
    desc 'play <URI|Podcast XML|FILE|DIR> [-r|--repeat] [-s|--shuffle]', 'Play video(URI or Podcast XML URI or local video file path or video directory)'
    method_option :repeat,  :aliases => '-r', :desc => 'Repeat play',  :type => :boolean
    method_option :shuffle, :aliases => '-s', :desc => 'Shuffle play', :type => :boolean
    def play(target)
      controller = Controller.new
      Playlist.new(options).add(target).entries do |media|
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
