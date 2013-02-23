module AirPlayer
  class Device
    def initialize
      @airplay = Airplay::Client.new
    rescue Airplay::Client::ServerNotFoundError
      abort "[ERROR] AirPlay device is not found"
    end

    def list
      @airplay.browse
    end
  end
end
