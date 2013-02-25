module AirPlayer
  class Device
    def initialize
      @airplay = Airplay::Client.new
    rescue Airplay::Client::ServerNotFoundError
      abort "[ERROR] AirPlay device is not found"
    end

    def default
      @airplay.browse.first
    end

    def exist?(device_number)
      !!@airplay.browse.at(device_number)
    end

    def get(device_number)
      @airplay.browse[device_number]
    end

    def list
      @airplay.browse.each_with_index do |device, number|
        puts "#{number}: #{device.name} (#{device.ip}:#{device.port})"
      end
    end
  end
end
