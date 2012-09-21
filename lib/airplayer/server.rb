require 'rack'
require 'socket'

module AirPlayer
  class Server
    attr_reader :uri

    def initialize(video_path)
      @server = Rack::Server.new(:server => :webrick, :Host => local_ip, :Port => 7070)
      @server.instance_variable_set(:@app, Rack::File.new(video_path))
      @uri  = "http://#{@server.options[:Host]}:#{@server.options[:Port]}"
    end

    def start
      # silenced WEBrick access log
      $stderr = File.open('/dev/null', 'w')
      @server.start
      $stderr = STDERR
    end

    # networking - Getting the Hostname or IP in Ruby on Rails - Stack Overflow
    #   http://stackoverflow.com/questions/42566/getting-the-hostname-or-ip-in-ruby-on-rails
    def local_ip
      # turn off reverse DNS resolution temporarily
      orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true

      UDPSocket.open do |s|
        s.connect('8.8.8.8', 1)
        s.addr.last
      end
    ensure
      Socket.do_not_reverse_lookup = orig
    end
  end
end
