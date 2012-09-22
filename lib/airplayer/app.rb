require 'thor'

module AirPlayer
  class App < Thor
    desc 'play [URI|FILE]', 'Play video(URI or local video file path)'
    def play(uri)
      Player.new.play(uri)
    rescue Airplay::Client::ServerNotFoundError
      abort '[ERROR] Apple device not found'
    end

    map '--version' => :version
    desc 'version, --version', 'Display version'
    def version
      puts VERSION
    end
  end
end
