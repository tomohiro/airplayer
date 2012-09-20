require 'rack'

module AirPlayer
  class Server
    attr_reader :uri
    def initialize(video_path)
      @server = Rack::Server.new
      @server.instance_variable_set(:@app, Rack::File.new(video_path))
      @uri  = "http://#{@server.options[:Host]}:#{@server.options[:Port]}"
    end

    def start
      @server.start
    end
  end
end
